"""Generate the SafeClean.png action-bar icon (100x100 RGBA, template-tinted)."""
import os
from PIL import Image, ImageDraw

S = 400  # supersampled canvas
OUT = 100

img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
d = ImageDraw.Draw(img)

# Shield silhouette
shield = [(200, 26), (356, 74), (356, 196), (200, 374), (44, 196), (44, 74)]
d.polygon(shield, fill=(255, 255, 255, 255))

# Round the shoulders / bottom tip a little
d.ellipse([44, 26, 356, 122], fill=(255, 255, 255, 255))
d.ellipse([150, 320, 250, 400], fill=(255, 255, 255, 255))

# Punch out a check mark so the template tint shows the symbol
check = [(128, 202), (176, 252), (276, 140)]
d.line(check, fill=(0, 0, 0, 0), width=38, joint="curve")
for p in (check[0], check[-1]):
    d.ellipse([p[0] - 19, p[1] - 19, p[0] + 19, p[1] + 19], fill=(0, 0, 0, 0))

img = img.resize((OUT, OUT), Image.LANCZOS)

dst = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..",
                   "layout", "Library", "Application Support", "AppData2",
                   "Resources.bundle", "SafeClean.png")
dst = os.path.normpath(dst)
img.save(dst)
print("wrote", dst, img.size, img.mode)