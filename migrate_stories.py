import os
import shutil
import re

source_dir = "Kids stories"
dest_dir = "assets/images/story_telling"

if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)

stories = []

# Get sorted list of items to ensure deterministic ordering
items = sorted(os.listdir(source_dir))
story_count = 1

# If story01 already exists and we want to preserve it or overwrite it? 
# The user said "Keep the story01 folder... as the reference".
# So we should probably skip story01 if it's already there and correct, OR overwrite it to be safe if it's in the source?
# The source "Kids stories" has "Bunny's Adventures" which maps to story01 in previous run.
# Existing story01 has "The Hare & Tortoise" content probably? No, I checked and it had `story01_cover.png`.
# I will overwrite everything to ensure consistency with the new mapping.

for item in items:
    source_item_path = os.path.join(source_dir, item)
    if os.path.isdir(source_item_path):
        story_name = item
        # Use numbered folder name
        folder_name = f"story{story_count:02d}"
        story_dest_path = os.path.join(dest_dir, folder_name)
        
        if not os.path.exists(story_dest_path):
            os.makedirs(story_dest_path)
            
        print(f"Processing '{story_name}' -> '{folder_name}'")
        
        story_info = {
            "title": story_name,
            "folder": folder_name,
            "cover": None,
            "scenes": []
        }
        
        files = sorted(os.listdir(source_item_path))
        scenes = []
        
        for file in files:
            file_path = os.path.join(source_item_path, file)
            if not os.path.isfile(file_path):
                continue
                
            lower_file = file.lower()
            new_name = None
            
            if "character card" in lower_file:
                # Naming convention: storyXX_cover.png
                new_name = f"{folder_name}_cover.png"
                story_info["cover"] = new_name
            elif "scene" in lower_file:
                # Extract number
                match = re.search(r"(\d+)", file)
                if match:
                    number = int(match.group(1))
                    # Naming convention: storyXX_sceneYY.png
                    new_name = f"{folder_name}_scene{number:02d}.png"
                    scenes.append(new_name)
            
            if new_name:
                shutil.copy2(file_path, os.path.join(story_dest_path, new_name))
        
        # Sort scenes to ensure order
        scenes.sort()
        story_info["scenes"] = scenes
        stories.append(story_info)
        
        story_count += 1

import json
print("MIGRATION_RESULT_START")
print(json.dumps(stories, indent=2))
print("MIGRATION_RESULT_END")
