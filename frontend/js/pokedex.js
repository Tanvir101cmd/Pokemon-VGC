const API_URL = "http://localhost:3000";

/* ===========================
   LOAD TYPES FROM DATABASE
=========================== */
function loadTypes() {
  fetch(`${API_URL}/types`)
    .then((res) => res.json())
    .then((types) => {
      const select = document.getElementById("typeFilter");
      // Clear existing options except "All Types"
      while (select.options.length > 1) {
        select.remove(1);
      }

      types.forEach((t) => {
        const option = document.createElement("option");
        option.value = t.type_name;
        option.textContent = t.type_name;
        select.appendChild(option);
      });
    })
    .catch((err) => console.error("Error loading types:", err));
}

/* ===========================
   PARSE TYPES FUNCTION
=========================== */
function parseTypes(types) {
  if (!types) return [];
  if (Array.isArray(types)) return types;
  if (typeof types === "string") {
    try {
      return JSON.parse(types);
    } catch (e) {
      return types.split(",").map((t) => t.trim());
    }
  }
  return [];
}

/* ===========================
   LOAD ALL POKEMON
=========================== */
function loadPokemon() {
  console.log("Loading Pokémon...");

  const search = document.getElementById("searchInput")?.value || "";
  const type = document.getElementById("typeFilter")?.value || "";

  let url = `${API_URL}/pokemon?search=${encodeURIComponent(search)}`;
  if (type) url += `&type=${encodeURIComponent(type)}`;

  console.log("API URL:", url);

  const grid = document.getElementById("pokedex");

  // Show loading
  grid.innerHTML = `
    <div style="grid-column: 1 / -1; text-align: center; padding: 40px;">
      <div style="font-size: 18px; color: #666; margin-bottom: 10px;">Loading Pokémon...</div>
      <div style="font-size: 14px; color: #999;">Fetching from: ${url}</div>
    </div>
  `;

  fetch(url)
    .then((res) => {
      if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
      return res.json();
    })
    .then((pokemon) => {
      console.log(`Received ${pokemon.length} Pokémon`);

      // Clear grid
      grid.innerHTML = "";

      if (pokemon.length === 0) {
        grid.innerHTML = `
          <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
            No Pokémon found. Try a different search!
          </div>
        `;
        return;
      }

      // Show count
      const countDiv = document.createElement("div");
      countDiv.style.cssText = `
        grid-column: 1 / -1;
        text-align: center;
        padding: 10px;
        color: #666;
        font-size: 14px;
        margin-bottom: 10px;
      `;
      countDiv.textContent = `Showing ${pokemon.length} Pokémon`;
      grid.appendChild(countDiv);

      // Create cards for each Pokémon
      pokemon.forEach((p) => {
        const card = document.createElement("div");
        card.className = "pokedex-card";
        card.dataset.id = p.id;

        // Parse types
        const types = parseTypes(p.types);

        // Create card HTML
        card.innerHTML = `
          <div class="pokemon-id">#${String(p.id).padStart(3, "0")}</div>
          <div class="pokemon-sprite">
            <img src="https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${p.id}.png"
                 alt="${p.name}"
                 loading="lazy"
                 onerror="this.onerror=null; this.src='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png'">
          </div>
          <h3>${p.name}</h3>
          <div class="types-container">
            ${types
              .map(
                (t) => `
              <span class="type-badge type-${t.toLowerCase().replace(/\s+/g, "-")}">${t}</span>
            `,
              )
              .join("")}
          </div>
        `;

        // Make clickable
        card.addEventListener("click", () => {
          window.location.href = `pokedex.html?id=${p.id}`;
        });

        grid.appendChild(card);
      });

      console.log(`Displayed ${pokemon.length} Pokémon cards`);
    })
    .catch((err) => {
      console.error("Error loading Pokémon:", err);
      grid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: red;">
          <h3>Error Loading Pokémon</h3>
          <p>${err.message}</p>
          <p>Make sure the backend server is running: <code>node server.js</code></p>
          <button onclick="loadPokemon()" style="margin-top: 10px; padding: 8px 16px; background: #ff1a1a; color: white; border: none; border-radius: 5px; cursor: pointer;">
            Try Again
          </button>
        </div>
      `;
    });
}

/* ===========================
   DETAIL VIEW
=========================== */
function loadPokemonDetail(id) {
  console.log(`Loading detail for Pokémon ID: ${id}`);

  fetch(`${API_URL}/pokemon/${id}`)
    .then((res) => {
      if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
      return res.json();
    })
    .then((pokemon) => {
      renderDetail(pokemon);
    })
    .catch((err) => {
      console.error("Error loading Pokémon detail:", err);
      // If detail fails, go back to main view
      window.history.replaceState({}, "", "pokedex.html");
      loadPokemon();
    });
}

function renderDetail(p) {
  console.log("Rendering detail for:", p.name);

  const grid = document.getElementById("pokedex");
  grid.style.display = "none";

  // Remove existing detail if any
  const existingDetail = document.getElementById("pokemon-detail");
  if (existingDetail) {
    existingDetail.remove();
  }

  const container = document.createElement("section");
  container.id = "pokemon-detail";
  container.style.padding = "20px";

  // Parse types
  const types = parseTypes(p.types);

  container.innerHTML = `
    <button id="detail-back" style="margin-bottom: 20px; padding: 10px 20px; background: #ff1a1a; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
      ← Back to Pokédex
    </button>

    <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
      <h1 style="margin-bottom: 20px; color: #2a2a2a;">
        #${String(p.id).padStart(3, "0")} ${p.name}
      </h1>

      <div style="text-align: center; margin: 30px 0;">
        <img src="https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${p.id}.png"
             alt="${p.name}"
             style="width: 200px; height: 200px; image-rendering: pixelated; background: linear-gradient(135deg, #f8f9fa, #e9ecef); border-radius: 20px; padding: 20px; border: 5px solid #dee2e6;">
      </div>

      <div style="margin: 20px 0;">
        <h3 style="margin-bottom: 10px;">Types</h3>
        <div>
          ${types
            .map(
              (t) => `
            <span class="type-badge type-${t.toLowerCase().replace(/\s+/g, "-")}" style="font-size: 16px; padding: 8px 15px; margin: 0 5px 5px 0;">${t}</span>
          `,
            )
            .join("")}
        </div>
      </div>

      ${
        p.abilities && p.abilities.length > 0
          ? `
      <div style="margin: 20px 0;">
        <h3 style="margin-bottom: 10px;">Abilities</h3>
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
          ${p.abilities
            .map(
              (ability) => `
            <span style="background: #f0f0f0; padding: 8px 15px; border-radius: 20px; font-weight: bold;">${ability}</span>
          `,
            )
            .join("")}
        </div>
      </div>
      `
          : ""
      }

      ${
        p.stats && Object.keys(p.stats).length > 0
          ? `
      <div style="margin: 30px 0;">
        <h3 style="margin-bottom: 15px;">Base Stats</h3>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;">
          ${Object.entries(p.stats)
            .map(
              ([stat, value]) => `
            <div style="background: #f8f9fa; padding: 15px; border-radius: 10px; text-align: center; border-left: 4px solid #ff1a1a;">
              <div style="font-size: 12px; color: #666; text-transform: uppercase; margin-bottom: 5px;">${stat.replace("_", " ")}</div>
              <div style="font-size: 24px; font-weight: bold; color: #2a2a2a;">${value}</div>
            </div>
          `,
            )
            .join("")}
        </div>
      </div>
      `
          : ""
      }

      ${
        p.moves && p.moves.length > 0
          ? `
      <div style="margin: 30px 0;">
        <h3 style="margin-bottom: 15px;">Moves (${Math.min(p.moves.length, 50)} shown)</h3>
        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 10px; max-height: 300px; overflow-y: auto; padding: 10px; background: #f8f9fa; border-radius: 10px;">
          ${p.moves
            .slice(0, 50)
            .map(
              (move) => `
            <div style="background: white; padding: 10px; border-radius: 5px; border: 1px solid #e0e0e0;">
              <div style="font-weight: bold; margin-bottom: 5px;">${move.name}</div>
              <div style="font-size: 12px; color: #666;">
                ${move.power ? `Power: ${move.power} | ` : ""}
                ${move.type ? `Type: ${move.type}` : ""}
              </div>
            </div>
          `,
            )
            .join("")}
        </div>
      </div>
      `
          : ""
      }
    </div>
  `;

  document.querySelector(".main").appendChild(container);

  // Add back button event
  document.getElementById("detail-back").addEventListener("click", () => {
    window.history.replaceState({}, "", "pokedex.html");
    container.remove();
    grid.style.display = "";
    loadPokemon();
  });
}

/* ===========================
   INITIALIZATION
=========================== */
document.addEventListener("DOMContentLoaded", function () {
  console.log("DOM fully loaded");

  // Check URL for Pokémon ID
  const urlParams = new URLSearchParams(window.location.search);
  const pokemonId = urlParams.get("id");

  if (pokemonId) {
    // We're viewing a single Pokémon
    console.log(`Viewing Pokémon detail: ID ${pokemonId}`);
    loadPokemonDetail(pokemonId);
  } else {
    // We're viewing the full Pokédex
    console.log("Viewing full Pokédex");

    // Load types dropdown
    loadTypes();

    // Load all Pokémon
    loadPokemon();

    // Add event listeners for search/filter
    const searchInput = document.getElementById("searchInput");
    const typeFilter = document.getElementById("typeFilter");

    if (searchInput) {
      searchInput.addEventListener("input", function () {
        console.log("Search input changed:", this.value);
        loadPokemon();
      });
    }

    if (typeFilter) {
      typeFilter.addEventListener("change", function () {
        console.log("Type filter changed:", this.value);
        loadPokemon();
      });
    }
  }
});

// Make functions available globally for debugging
window.loadPokemon = loadPokemon;
window.loadPokemonDetail = loadPokemonDetail;
console.log("pokedex.js loaded successfully");
