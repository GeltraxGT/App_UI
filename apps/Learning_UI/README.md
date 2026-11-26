# Learning UI

Flutter rebuild of the reference learning-app home screenshot.

## What it shows

- Top bar: profile photo, search and notification buttons
- **Jan 15, Thursday** green schedule card:
  **Intro to Front-End Development** 09:15 – 11:45 AM,
  **Digital Product Creation** 12:45 – 03:00 PM,
  **Startup & Product Development** 03:30 – 05:00 PM (faded, as in
  the screenshot — its time is not visible there, so this is sample
  data)
- **Let's talk right now!** pink card with **Start chat** button, and
  **21:30 Hours spent** blue card with a 75% clock ring
- **Active lessons** with **View all**:
  **Intro to Front-End Development**, 28 lessons • 17 hours,
  **5 lessons left**; **Startup & Product Development**,
  18 lessons • 12 hours, **8 lessons left** (second card's numbers
  are sample data — only its title is visible in the screenshot)
- Bottom nav: Home / Calendar / Lessons / Chat, floating pill

## Images

Generated, in `assets/images/`:

- `profile_avatar.jpg` — woman in an orange top (AI-generated photo
  for the avatar; not a real person)
- `chat_bubbles.jpg` — pink / blue glass chat bubbles
- `code_cube.jpg` — glass cube with an orange `</>` symbol
- `startup.jpg` — glass rocket, lightbulb and chart on green

Learner avatars on the lesson cards are coloured initial circles,
not photos.

## Layout

Responsive, not hard-coded to one phone: side-by-side cards use
`Expanded`, lesson titles wrap, 20px side padding, 16 / 20px
spacing between sections. The page scrolls vertically.

## Verify

```sh
flutter analyze   # 0 issues
flutter test      # 2/2 passed (label test + 390x844 golden)
flutter build web # builds
```

Live look on a real phone is still unverified — the golden is a
layout check (test font / placeholder images), not a real render.
