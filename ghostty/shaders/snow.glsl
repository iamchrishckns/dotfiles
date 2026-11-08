// snow.glsl
//
// Layered snowfall for Ghostty.
// Flakes only ever fall downward. They drift side to side in a lazy, irregular
// way, and the whole snowfall is pushed around by slow gusts of wind.
// Everything you'd want to tweak is in the TUNABLES block below.
// 
// Crafted with Sonnet 5.5 Medium

// ============================== TUNABLES ===================================

// --- Amount ---------------------------------------------------------------
// const int   LAYERS        = 3;     // depth layers (1-8). More = denser, richer, costlier.
// const float DENSITY       = 0.25;  // 0..1  chance a grid cell holds a flake. Main "amount" knob.

// --- Size -----------------------------------------------------------------
// const float FLAKE_SIZE_FAR  = 1.0; // flake radius in px for the farthest layer
// const float FLAKE_SIZE_NEAR = 3.5; // flake radius in px for the nearest layer
// const float SOFTNESS        = 0.6; // 0 = hard-edged dots, 1 = very soft/blurry
// const float SPACING         = 4.5; // grid cell height relative to flake radius. Higher = sparser.
// const float UI_SCALE        = 1.0; // multiply sizes/speeds (use 2.0 on HiDPI/Retina if too small)

// --- Motion ---------------------------------------------------------------
// const float FALL_SPEED      = 110.0; // px/second for the nearest layer
// const float PARALLAX        = 0.45;  // far-layer speed as a fraction of near-layer (0..1)
// const float SPEED_VARIATION = 0.45;  // 0..1  per-column speed randomness (less uniform look)
// const float WIND            = 0.0;   // px/second constant sideways drift (+ right, - left)

// --- Side-to-side movement ------------------------------------------------
// const float SWAY            = 0.85;  // 0..1  how far each flake wanders sideways
// const float SWAY_WIDTH      = 5;   // how much horizontal room a flake has (bigger = wider swings)
// const float SWAY_SPEED      = 0.9;   // wobble frequency
// const float GUST            = 25.0;  // px  how far slow wind gusts push the whole snowfall (0 = off)
// const float GUST_SPEED      = 0.35;  // how quickly gusts change

// --- Look -----------------------------------------------------------------
// const vec3  SNOW_COLOR      = vec3(0.85, 0.93, 1.0);
// const float INTENSITY       = 0.9;   // 0..1  overall opacity of the snow
// const float DEPTH_FADE      = 0.55;  // 0..1  how much dimmer far flakes are than near ones
// const float TWINKLE         = 0.35;  // 0..1  random per-flake brightness variation
// const float BOTTOM_FADE     = 0.0;   // 0..1  fade snow out toward the bottom (0 = off)

// --- Light -----------------------------------------------------------------
// const int   LAYERS        = 2;
// const float DENSITY       = 0.18;
// 
// const float FLAKE_SIZE_FAR  = 0.9;
// const float FLAKE_SIZE_NEAR = 3.0;
// const float SOFTNESS        = 0.6;
// const float SPACING         = 4.5;
// const float UI_SCALE        = 1.0;
// 
// const float FALL_SPEED      = 60.0;
// const float PARALLAX        = 0.5;
// const float SPEED_VARIATION = 0.45;
// const float WIND            = 0.0;
// 
// const float SWAY            = 0.9;
// const float SWAY_WIDTH      = 10;
// const float SWAY_SPEED      = 0.7;
// const float GUST            = 15.0;
// const float GUST_SPEED      = 0.3;
// 
// const vec3  SNOW_COLOR      = vec3(0.85, 0.93, 1.0);
// const float INTENSITY       = 0.6;
// const float DEPTH_FADE      = 0.55;
// const float TWINKLE         = 0.35;
// const float BOTTOM_FADE     = 0.0;

// --- Normal -----------------------------------------------------------------
const int   LAYERS        = 4;
const float DENSITY       = 0.25;

const float FLAKE_SIZE_FAR  = 1.0;
const float FLAKE_SIZE_NEAR = 5.0;
const float SOFTNESS        = 0.6;
const float SPACING         = 4.5;
const float UI_SCALE        = 1.0;

const float FALL_SPEED      = 100.0;
const float PARALLAX        = 0.45;
const float SPEED_VARIATION = 0.45;
const float WIND            = 0.0;

const float SWAY            = 0.85;
const float SWAY_WIDTH      = 6;
const float SWAY_SPEED      = 0.9;
const float GUST            = 25.0;
const float GUST_SPEED      = 0.35;

const vec3  SNOW_COLOR      = vec3(0.85, 0.93, 1.0);
const float INTENSITY       = 0.8;
const float DEPTH_FADE      = 0.55;
const float TWINKLE         = 0.35;
const float BOTTOM_FADE     = 0.0;

// --- Heavy -----------------------------------------------------------------
// const int   LAYERS        = 7;
// const float DENSITY       = 0.6;
// 
// const float FLAKE_SIZE_FAR  = 1.0;
// const float FLAKE_SIZE_NEAR = 4.0;
// const float SOFTNESS        = 0.6;
// const float SPACING         = 6;
// const float UI_SCALE        = 1.0;
// 
// const float FALL_SPEED      = 280.0;
// const float PARALLAX        = 0.4;
// const float SPEED_VARIATION = 0.35;
// const float WIND            = 45.0;
// 
// const float SWAY            = 0.6;
// const float SWAY_WIDTH      = 10;
// const float SWAY_SPEED      = 1.2;
// const float GUST            = 45.0;
// const float GUST_SPEED      = 0.5;
// 
// const vec3  SNOW_COLOR      = vec3(0.85, 0.93, 1.0);
// const float INTENSITY       = 0.95;
// const float DEPTH_FADE      = 0.5;
// const float TWINKLE         = 0.3;
// const float BOTTOM_FADE     = 0.0;

// ===========================================================================

// Cheap, sin-free hashes (stay stable at large coordinates / long uptimes).
float hash12(vec2 p) {
  vec3 p3 = fract(vec3(p.xyx) * 0.1031);
  p3 += dot(p3, p3.yzx + 33.33);
  return fract((p3.x + p3.y) * p3.z);
}

vec2 hash22(vec2 p) {
  vec3 p3 = fract(vec3(p.xyx) * vec3(0.1031, 0.1030, 0.0973));
  p3 += dot(p3, p3.yxz + 33.33);
  return fract((p3.xx + p3.yz) * p3.zy);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec4 terminal = texture(iChannel0, uv);

  float snow = 0.0;

  for (int i = 0; i < LAYERS; i++) {
    // 0 = farthest layer, 1 = nearest layer
    float depth = (LAYERS > 1) ? float(i) / float(LAYERS - 1) : 1.0;
    float seed  = float(i) * 17.31;
    float layerScale = mix(PARALLAX, 1.0, depth);

    float radius = mix(FLAKE_SIZE_FAR, FLAKE_SIZE_NEAR, depth) * UI_SCALE;
    float cellH  = radius * SPACING;
    float cellW  = cellH * SWAY_WIDTH;     // wider than tall: room to swing sideways
    float speed  = FALL_SPEED * UI_SCALE * layerScale;

    // Free room (in cell units) once the flake's radius is accounted for.
    // Keeping the flake inside this range means it never gets clipped by a
    // cell edge, so no neighbour search is needed.
    float roomX = 0.5 - radius / cellW;
    float roomY = 0.5 - radius / cellH;

    vec2 q = fragCoord;

    // Constant wind plus slow, irregular gusts that push every flake together.
    float gust = sin(iTime * GUST_SPEED + seed) + 0.5 * sin(iTime * GUST_SPEED * 2.7 + seed * 2.0);
    q.x -= (WIND * iTime + GUST * gust) * UI_SCALE * layerScale;
    q.x += seed * 131.0;

    float col = floor(q.x / cellW);

    // Per-column speed and phase so columns don't fall in lockstep.
    vec2  colRand  = hash22(vec2(col, seed));
    float colSpeed = speed * (1.0 + (colRand.x - 0.5) * 2.0 * SPEED_VARIATION);

    // Subtracting makes the pattern fall DOWN the screen in Ghostty.
    q.y -= colSpeed * iTime + colRand.y * 1000.0 * cellH;

    vec2 id = vec2(col, floor(q.y / cellH));
    vec2 f  = vec2(fract(q.x / cellW), fract(q.y / cellH));

    vec2  h  = hash22(id + seed);
    float h3 = hash12(id * 1.37 + seed + 7.0);

    // Does this cell have a flake?
    if (h3 >= DENSITY) continue;

    // Two out-of-sync sines per flake give an irregular, lazy wobble instead of
    // a metronome. Sway only moves horizontally and stays inside the cell, so
    // the only vertical motion is the downward fall.
    float p1 = h.x * 6.2831853;
    float p2 = h.y * 6.2831853;
    float sway =
      0.65 * sin(iTime * SWAY_SPEED * (0.6 + 0.8 * h.y) + p1) +
      0.35 * sin(iTime * SWAY_SPEED * (1.7 + 1.0 * h.x) + p2);

    vec2 center = vec2(
      0.5 + roomX * ((h.x * 2.0 - 1.0) * (1.0 - SWAY) + SWAY * sway),
      0.5 + roomY * (h.y * 2.0 - 1.0)
    );

    float r = radius * (0.55 + 0.45 * hash12(id + seed + 3.0)); // size variation
    float d = length((f - center) * vec2(cellW, cellH));

    float a = 1.0 - smoothstep(r * (1.0 - SOFTNESS), r, d);

    float brightness = mix(1.0 - DEPTH_FADE, 1.0, depth);
    brightness *= 1.0 - TWINKLE * hash12(id + seed + 11.0);

    snow += a * brightness;
  }

  snow = clamp(snow, 0.0, 1.0) * INTENSITY;

  // Optionally fade snow toward the bottom of the window.
  snow *= 1.0 - BOTTOM_FADE * (1.0 - uv.y);

  vec3 color = mix(terminal.rgb, SNOW_COLOR, snow);
  fragColor = vec4(color, terminal.a);
}
