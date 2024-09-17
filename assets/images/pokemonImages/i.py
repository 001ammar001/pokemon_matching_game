import os, glob, sys

print(os.chdir("D:/Projects/Android projects/mini_projects/assets/images/pokemonImages"))

images = glob.glob("*.png")

print(images)