// snow_windy.glsl
// 
// Moderate snowfall with a constant, gentle wind for Ghostty.

float hash21(vec2 p) {
  return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec4 terminalColor = texture(iChannel0, uv);

  float snow = 0.0;
  float gradient = (1.0 - uv.y) * 0.12;
  float random = hash21(fragCoord);

  // Always positive: wind continuously pushes flakes to the right.
  float wind = 0.022;

  for (int k = 0; k < 7; k++) {
    for (int i = 1; i < 13; i++) {
      float fi = float(i);
      float fk = float(k);

      float cellSize = 2.0 + fi * 3.0;
      float fallSpeed =
        0.30 + (sin(iTime * 0.4 + float(k + i * 20)) + 1.0) * 0.00008;

      vec2 snowUv = fragCoord / iResolution.x;

      // Constant rightward drift.
      // Nearer layers drift slightly more, giving a subtle parallax effect.
      // snowUv.x += wind * iTime * (1.0 + 3.0 / fi);
      snowUv.x -= wind * iTime * (1.0 + 3.0 / fi);

      // Tiny local movement. It does not alter the overall rightward wind.
      snowUv.x +=
        0.008 *
        sin(iTime * 0.75 + float(k * 31) + fi * 2.3) *
        (4.0 / fi);

      // Fall downward.
      snowUv.y -=
        fallSpeed *
        (iTime + float(k * 1352)) *
        (1.0 / fi);

      vec2 cell = ceil(snowUv * cellSize - vec2(0.5)) / cellSize;

      float x = fract(
        sin(
          dot(
            cell,
            vec2(12.9898 + fk * 12.0, 78.233 + fk * 315.156)
          )
        ) *
          43758.5453 +
          fk * 12.0
      ) - 0.5;

      float y = fract(
        sin(
          dot(
            cell,
            vec2(62.2364 + fk * 23.0, 94.674 + fk * 95.0)
          )
        ) *
          62159.8432 +
          fk * 12.0
      ) - 0.5;

      float flutterX = sin(iTime * 2.5 + fi) * 0.75 / cellSize;
      float flutterY = cos(iTime * 2.5 + fk) * 0.55 / cellSize;

      float d = 5.0 *
        distance(
          cell +
            vec2(x * sin(y), y) * flutterX +
            vec2(y, x) * flutterY,
          snowUv
        );

      float flakeChance = fract(
        sin(dot(cell, vec2(32.4691, 94.615))) * 31572.1684
      );

      if (flakeChance < 0.11) {
        float flake = (x + 1.0) * 0.38 *
          clamp(
            1.9 - d * (15.0 + x * 6.3) * (cellSize / 1.4),
            0.0,
            1.0
          );

        snow += flake;
      }
    }
  }

  snow = clamp(snow, 0.0, 0.95);

  vec3 snowColor = vec3(0.78, 0.90, 1.0);
  vec3 overlay = snowColor * snow;

  overlay += gradient * vec3(0.025, 0.05, 0.09);
  overlay += vec3(random * 0.002);

  fragColor = vec4(terminalColor.rgb + overlay, terminalColor.a);
}
