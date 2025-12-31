const API_URL = 'http://localhost:3000';

/* ===========================
   LOAD TYPES FROM DATABASE
=========================== */
function loadTypes() {
  fetch(`${API_URL}/types`)
    .then(res => res.json())
    .then(types => {
      const select = document.getElementById('typeFilter');
      types.forEach(t => {
        const option = document.createElement('option');
        option.value = t.type_name;
        option.textContent = t.type_name;
        select.appendChild(option);
      });
    });
}

/* ===========================
  UTILITIES
=========================== */
function parseTypes(typesField) {
  if (!typesField) return [];
  if (Array.isArray(typesField)) return typesField.map(t => String(t).trim()).filter(Boolean);
  
  try {
   const parsed = JSON.parse(typesField);
   if (Array.isArray(parsed)) return parsed.map(t => String(t).trim()).filter(Boolean);
  } catch (e) {}
  // fallback: split on common delimiters
  const str = String(typesField);
  const parts = str.split(/[,\/|;]+/).map(s => s.trim()).filter(Boolean);
  if (parts.length > 0) return parts;
  return [];
}

/* ===========================
  LOAD POKEMON WITH FILTERS
=========================== */
function loadPokemon() {
  const search = document.getElementById('searchInput').value;
  const type = document.getElementById('typeFilter').value;

  let url = `${API_URL}/pokemon?search=${encodeURIComponent(search)}`;
  if (type) url += `&type=${encodeURIComponent(type)}`;

  fetch(url)
    .then(res => res.json())
    .then(pokemon => {
      const grid = document.getElementById('pokedex');
      grid.innerHTML = '';

      pokemon.forEach(p => {
        const card = document.createElement('div');
        card.className = 'pokedex-card';

        const typesArr = parseTypes(p.types);

        card.innerHTML = `
              <h3>#${p.id} ${p.name}</h3>
              <div>
                ${typesArr.map(t => `<span class="type-badge type-${t.toLowerCase().replace(/\s+/g,'-')}">${t}</span>`).join('')}
              </div>
            `;

        // attach id and make card clickable to navigate to a detail view
        card.dataset.id = p.id;
        card.style.cursor = 'pointer';
        card.addEventListener('click', () => {
          // navigate to same page with query param (frontend can read ?id= to load details)
          window.location.href = `pokedex.html?id=${p.id}`;
        });

        grid.appendChild(card);
      });
    });
}

loadTypes();
loadPokemon();
// If URL has ?id=, fetch and render detail view
function loadDetailFromQuery() {
  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  if (!id) return;

  fetch(`${API_URL}/pokemon/${id}`)
    .then(res => {
      if (!res.ok) throw new Error('Not found');
      return res.json();
    })
    .then(p => renderDetail(p))
    .catch(err => {
      console.error('Failed to load pokemon detail', err);
    });
}

function renderDetail(p) {
  // hide grid
  const grid = document.getElementById('pokedex');
  grid.style.display = 'none';

  // remove existing detail if any
  let existing = document.getElementById('pokemon-detail');
  if (existing) existing.remove();

  const container = document.createElement('section');
  container.id = 'pokemon-detail';
  container.style.padding = '20px';
  const detailTypes = parseTypes(p.types);

  container.innerHTML = `
    <button id="detail-back" style="margin-bottom:12px;">← Back</button>
    <h2>#${p.id} ${p.name}</h2>
    <div><strong>Types:</strong> ${ detailTypes.map(t => `<span class="type-badge type-${t.toLowerCase().replace(/\s+/g,'-')}">${t}</span>`).join(' ') }</div>
    <div><strong>Abilities:</strong> ${ (p.abilities || []).join(', ') }</div>
    <div style="margin-top:12px;"><strong>Moves:</strong></div>
    <ul id="moves-list">${ (p.moves || []).slice(0,100).map(m => `<li>${m.name}${m.power? ` — ${m.power} BP`:''} ${m.type? `(${m.type})`:''}</li>`).join('') }</ul>
  `;

  document.querySelector('.main').appendChild(container);

  document.getElementById('detail-back').addEventListener('click', () => {
    // remove query param and show grid
    window.history.replaceState({}, '', 'pokedex.html');
    container.remove();
    grid.style.display = '';
  });
}

// run on load
loadDetailFromQuery();
