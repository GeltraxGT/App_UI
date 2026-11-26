# Gallery UI

Flutter rebuild of the reference Gallery screenshot — a music cover-art
gallery screen.

## What it shows

- Header: settings button, centred **Gallery** title
- **Get the Best Experience** — Connect Account cards:
  **Spotify** ("Seamlessly update playlists.") and **Apple Music**
  ("Create personalized playlists." — the screenshot cuts this off at
  "Create personaliz", so the full line is completed from the parallel
  Spotify wording)
- **Collections** — **Summer** (watermelon) and **Halloween** (pumpkin)
- **Free Artworks** — "No catches, just awesome covers."
  **Surf Rock** (SURF / ROCK), **Running Tracks** ("running tracks"),
  **East Country** (EAST / COUNTRY — only partly visible in the
  screenshot, drawn as a sunset-gradient cover, not a photo)
- **Recently Added** — Summer, Surf Rock, Running Tracks
- Bottom nav: **My Covers** / **Gallery** (Gallery selected), floating pill

## Images

Generated, in `assets/images/`:

- `summer.jpg` — watermelon slices on mint green
- `halloween.jpg` — glowing pumpkin, purple night
- `surf_rock.jpg` — surfer in a red wetsuit on a big wave
- `running_tracks.jpg` — runner in motion, warm tones

Cover titles (SURF / ROCK, running tracks, Summer, Halloween) are
Flutter text over the images, so they stay crisp. East Country is a
gradient cover made in Flutter.

## Layout

Responsive, not hard-coded to one phone: card widths are a fraction
of the screen width, 20px side padding, 12px gaps between cards,
16 / 24 / 28px spacing between sections. Horizontal rows scroll;
the page scrolls vertically.

## Verify

```sh
flutter analyze   # 0 issues
flutter test      # 2/2 passed (label test + 390x844 golden)
flutter build web # builds
```

Live look on a real phone is still unverified — the golden is a
layout check (test font / placeholder images), not a real render.
