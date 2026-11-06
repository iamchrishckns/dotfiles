// snow.glsl
// 
// Regular snowfall for Ghostty.

float hash21(vec2 p) {
  return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  // Ghostty provides the terminal framebuffer here.
  vec4 terminalColor = texture(iChannel0, uv);

  float snow = 0.0;

  // Use Y resolution for a top-to-bottom gradient.
  float gradient = (1.0 - uv.y) * 0.18;
  float random = hash21(fragCoord);

  // Keep these fairly modest: terminal shaders run all the time.
  for (int k = 0; k < 6; k++) {
    for (int i = 1; i < 12; i++) {
      float fi = float(i);
      float fk = float(k);

      float cellSize = 2.0 + fi * 3.0;
      float downSpeed =
        0.30 + (sin(iTime * 0.4 + float(k + i * 20)) + 1.0) * 0.00008;

      vec2 snowUv = fragCoord / iResolution.x;

      snowUv.x +=
        0.01 *
        sin((iTime + float(k * 6185)) * 0.6 + fi) *
        (5.0 / fi);

      // Use subtraction so flakes move downward in the usual Ghostty view.
      snowUv.y -=
        downSpeed *
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

      float randomMagnitude1 = sin(iTime * 2.5) * 0.7 / cellSize;
      float randomMagnitude2 = cos(iTime * 2.5) * 0.7 / cellSize;

      float d = 5.0 *
        distance(
          cell +
            vec2(x * sin(y), y) * randomMagnitude1 +
            vec2(y, x) * randomMagnitude2,
          snowUv
        );

      float flakeChance = fract(
        sin(dot(cell, vec2(32.4691, 94.615))) * 31572.1684
      );

      if (flakeChance < 0.08) {
        float flake = (x + 1.0) * 0.4 *
          clamp(
            1.9 - d * (15.0 + x * 6.3) * (cellSize / 1.4),
            0.0,
            1.0
          );

        snow += flake;
      }
    }
  }

  // Prevent too-bright white blocks where flakes overlap.
  snow = clamp(snow, 0.0, 1.0);

  // Slightly blue-white snow. `mix` avoids washing out the terminal entirely.
  vec3 snowColor = vec3(0.78, 0.90, 1.0);
  vec3 overlay = snowColor * snow;

  // Small atmospheric tint; lower this to 0.0 if undesired.
  overlay += gradient * vec3(0.03, 0.06, 0.10);
  overlay += vec3(random * 0.003);

  fragColor = vec4(terminalColor.rgb + overlay, terminalColor.a);
}
