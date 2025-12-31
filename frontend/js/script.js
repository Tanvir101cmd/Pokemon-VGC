function searchPokemon() {
    const input = document.getElementById('pokeInput').value;
    const resultsDiv = document.getElementById('results');

    if (!input) return;

    // Fetch from the Node.js API running on port 3000
    fetch(`http://localhost:3000/pokemon/search?name=${input}`)
        .then(res => res.json())
        .then(data => {
            resultsDiv.innerHTML = '';
            
            if (data.length === 0) {
                resultsDiv.innerHTML = '<p>No Pokémon found.</p>';
                return;
            }

            data.forEach(p => {
                const div = document.createElement('div');
                div.className = 'poke-card';
                div.innerHTML = `
                    <h3>${p.name} (#${p.id})</h3>
                    <p>Type: ${p.type_name || 'Unknown'}</p>
                    <p>Ability: ${p.ability_name || 'None'}</p>
                `;
                resultsDiv.appendChild(div);
            });
        })
        .catch(err => {
            console.error(err);
            resultsDiv.innerHTML = '<p>Error connecting to server.</p>';
        });
}