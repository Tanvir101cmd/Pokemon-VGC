<?php
/* ---------- DATABASE CONNECTION ---------- */
require_once("DBConnect.php");

/* ---------- READ POST DATA ---------- */
$attacker_name = $_POST['attacker'];
$defender_name = $_POST['defender'];
$attacker_level= $_POST['attacker_level'];
$move_name     = $_POST['move'];

/* ---------- GET ATTACKER POKEMON ID ---------- */
$stmt = $conn->prepare("SELECT sid FROM Pokemon WHERE name = ?");
$stmt->bind_param("s", $attacker_name);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    $error="Invalid attacking Pokémon";
    header("Location: ../dmgCalcWeb.php?damage=$error");
    exit();
}
$attacker_sid = $result->fetch_assoc()['sid'];

/* ---------- GET DEFENDER POKEMON ID ---------- */
$stmt = $conn->prepare("SELECT sid FROM Pokemon WHERE name = ?");
$stmt->bind_param("s", $defender_name);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    $error="Invalid defending Pokémon";
    header("Location: ../dmgCalcWeb.php?damage=$error");
    exit();
}
$defender_sid = $result->fetch_assoc()['sid'];

/* ---------- GET ATTACKER BASE STATS ---------- */
$stmt = $conn->prepare("
    SELECT hp, attack, sp_atk, defence, sp_def, spd
    FROM bst
    WHERE pokemon_sid = ?
");
$stmt->bind_param("i", $attacker_sid);
$stmt->execute();
$attacker_stats = $stmt->get_result()->fetch_assoc();
$attacker_hp        = $attacker_stats['hp'];
$attacker_attack    = $attacker_stats['attack'];
$attacker_sp_atk = $attacker_stats['sp_atk'];
$attacker_defence   = $attacker_stats['defence'];
$attacker_sp_def= $attacker_stats['sp_def'];
$attacker_spd       = $attacker_stats['spd'];

/* ---------- GET DEFENDER BASE STATS ---------- */
$stmt->bind_param("i", $defender_sid);
$stmt->execute();
$defender_stats = $stmt->get_result()->fetch_assoc();
$defender_hp        = $defender_stats['hp'];
$defender_attack    = $defender_stats['attack'];
$defender_sp_atk = $defender_stats['sp_atk'];
$defender_defence   = $defender_stats['defence'];
$defender_sp_def= $defender_stats['sp_def'];
$defender_spd       = $defender_stats['spd'];

/* ---------- GET MOVE DETAILS ---------- */
$stmt = $conn->prepare("
    SELECT code, power, accuracy, type_name, category
    FROM Moves
    WHERE name = ?
");
$stmt->bind_param("s", $move_name);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    $error="Invalid move";
    header("Location: ../dmgCalcWeb.php?damage=$error");
    exit();
}

$move = $result->fetch_assoc();
$move_code  = $move['code'];
$move_power = $move['power'];
$move_acc   = $move['accuracy'];
$move_type  = $move['type_name'];
$move_cat   = $move['category'];

/* ---------- CHECK IF POKEMON CAN USE THE MOVE ---------- */
$stmt = $conn->prepare("
    SELECT *
    FROM Pokemon_moves
    WHERE pokemon_sid = ? AND move_code = ?
");
$stmt->bind_param("ii", $attacker_sid, $move_code);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    $error="This Pokémon cannot use the selected move";
    header("Location: ../dmgCalcWeb.php?damage=$error");
    exit();
}


$defender_types = [];

$stmt = $conn->prepare(
    "SELECT type_name 
     FROM Pokemon_types 
     WHERE pokemon_sid = ?"
);
$stmt->bind_param("i", $defender_sid);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $defender_types[] = $row['type_name'];
}

$type_multiplier = 1.0;

$stmt = $conn->prepare(
    "SELECT strength, weakness 
     FROM Types 
     WHERE name = ?"
);
$stmt->bind_param("s", $move_type);
$stmt->execute();
$type_result = $stmt->get_result();
$type_data = $type_result->fetch_assoc();
$strengths = explode(',', $type_data['strength']);
$weaknesses = explode(',', $type_data['weakness']);
foreach ($defender_types as $def_type) {
    if (in_array($def_type, $strengths)) {
        $type_multiplier *= 2;
    }
    if (in_array($def_type, $weaknesses)) {
        $type_multiplier *= 0.5;
    }
}

$stab = 1.0;
$stmt = $conn->prepare(
    "SELECT type_name 
     FROM Pokemon_types 
     WHERE pokemon_sid = ?"
);
$stmt->bind_param("i", $attacker_sid);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    if ($row['type_name'] === $move_type) {
        $stab = 1.5;
        break;
    }
}

if ($move_cat === 'Physical') {
    $attack_stat  = $attacker_attack;
    $defence_stat = $defender_defence;
} else {
    $attack_stat  = $attacker_sp_atk;
    $defence_stat = $defender_sp_def;
}

$base_damage = (
    ((2 * $attacker_level / 5) + 2)
    * $move_power
    * ($attack_stat / $defence_stat)
) / 50 + 2;

$damage = "Damage Dealt: ".(string)floor($base_damage * $stab * $type_multiplier);
header("Location: ../dmgCalcWeb.php?damage=$damage");
exit();
?>