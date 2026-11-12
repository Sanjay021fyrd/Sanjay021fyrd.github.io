# Portfolio: T.M. Sanjay Kumar

A fast, dependency-free static site (HTML, CSS, JavaScript). No build step.

## Run locally

```powershell
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Then open http://localhost:8080.

## Edit your content

| What | Where |
| --- | --- |
| Text, projects, skills, links | `index.html` |
| Colours, fonts, spacing | `css/style.css` (colour variables at the top; dark mode follows the visitor's system setting) |
| Hoax Hunter screenshot | `assets/hoax-hunter.jpg` |
| Resume download | replace `assets/T_M_Sanjay_Kumar_Resume.pdf` |

There is no JavaScript and no build step.

## Deploy free on GitHub Pages

1. Create a GitHub repo named `Sanjay021fyrd.github.io` (or any name).
2. Push the contents of this folder to it (`serve.ps1` is not needed in production).
3. Repo Settings > Pages > Deploy from branch > `main` / root.
4. Your site goes live at `https://sanjay021fyrd.github.io/`.

Netlify and Vercel also work: drag and drop this folder.
