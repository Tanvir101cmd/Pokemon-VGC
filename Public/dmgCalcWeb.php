<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pokemon Damage Calculator</title>
    <link rel="stylesheet" href="css/style.css"> </head>
<body>

<aside class="sidebar" style="position: fixed; height: 100%; top: 0; left: 0;">
    <h2 class="logo">Menu</h2>
    <a href="homepage.html" style="display:block; padding:10px; color:white; text-decoration:none;">Dashboard</a>
    <a href="pokedex.html" style="display:block; padding:10px; color:white; text-decoration:none;">Pokédex</a>
    <a href="dmgCalcWeb.php" style="display:block; padding:10px; color:white; text-decoration:none; background: #333;">Calculator</a>
</aside>

<main class="main" style="margin-left: 220px;"> <div class="container">
        <h1>Pokemon Damage Calculator</h1>
        
        <form method="POST" action="php/dmgCalc.php">
        
        <div class="form-group">
            <label for="attacker">Attacking Pokémon Name</label>
            <input type="text" name="attacker" id="attacker" placeholder="e.g. Charizard" required>
        </div>

        <div class="form-group">
            <label for="attacker-level">Attacking Pokémon Level</label>
            <input type="number" name="attacker_level" id="attacker_level" placeholder="e.g. 50" value="50">
        </div>

        <div class="form-group">
            <label for="move">Move Used</label>
            <input type="text" name="move" id="move" placeholder="e.g. Flamethrower" required>
        </div>

        <div class="divider"></div>

        <div class="form-group">
            <label for="defender">Defending Pokémon Name</label>
            <input type="text" name="defender" id="defender" placeholder="e.g. Venusaur" required>
        </div>

        <button type="submit" class="calc-btn">Calculate Damage</button>
        </form>

        <div class="result-box">
            <h3>Damage Output</h3>
            <?php if (isset($_GET['damage'])): ?>
                <p><strong><?php echo htmlspecialchars($_GET['damage']); ?></strong></p>
            <?php else: ?>
                <p>Damage will be displayed here</p>
            <?php endif; ?>
        </div>
        <div class="pokeball">⚪🔴</div>
    </div>
</main>
</body>
</html>