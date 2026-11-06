// snow_light.glsl
// 
// Gentle snowfall for Ghostty.

float hash21(vec2 p) {
  return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec4 terminalColor = texture(iChannel0, uv);

  float snow = 0.0;
  float gradient = (1.0 - uv.y) * 0.05;
  float random = hash21(fragCoord);

  // Few layers and fairly rare flakes.
  for (int k = 0; k < 2; k++) {
    for (int i = 1; i < 8; i++) {
      float fi = float(i);
      float fk = float(k);

      float cellSize = 4.0 + fi * 4.5;
      float fallSpeed =
        0.08 + (sin(iTime * 0.3 + float(k + i * 20)) + 1.0) * 0.00003;

      vec2 snowUv = fragCoord / iResolution.x;

      snowUv.x +=
        0.005 *
        sin((iTime + float(k * 6185)) * 0.35 + fi) *
        (3.0 / fi);

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

      float flutterX = sin(iTime * 1.2) * 0.35 / cellSize;
      float flutterY = cos(iTime * 1.2) * 0.35 / cellSize;

      float d = 4.5 *
        distance(
          cell +
            vec2(x * sin(y), y) * flutterX +
            vec2(y, x) * flutterY,
          snowUv
        );

      float flakeChance = fract(
        sin(dot(cell, vec2(32.4691, 94.615))) * 31572.1684
      );

      if (flakeChance < 0.045) {
        float flake = (x + 1.0) * 0.22 *
          clamp(
            1.45 - d * (13.0 + x * 4.0) * (cellSize / 1.4),
            0.0,
            1.0
          );

        snow += flake;
      }
    }
  }

  snow = clamp(snow, 0.0, 0.45);

  vec3 snowColor = vec3(0.78, 0.89, 1.0);
  vec3 overlay = snowColor * snow;

  overlay += gradient * vec3(0.02, 0.04, 0.07);
  overlay += vec3(random * 0.0015);

  fragColor = vec4(terminalColor.rgb + overlay, terminalColor.a);
}
