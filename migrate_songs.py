import os
import shutil
import re
import json

source_dir = "Kids Songs"
dest_dir = "assets/video/sing_along"

if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)

def to_snake_case(name):
    # Remove extension
    base_name = os.path.splitext(name)[0]
    # Lowercase
    s1 = base_name.lower()
    # Replace non-alphanumeric with space
    s2 = re.sub(r"[^a-z0-9\s]", "", s1)
    # Replace spaces with underscores
    s3 = re.sub(r"\s+", "_", s2.strip())
    # Add extension back
    return s3 + ".mp4"

songs = []
items = sorted(os.listdir(source_dir))

for item in items:
    source_path = os.path.join(source_dir, item)
    if os.path.isfile(source_path) and item.lower().endswith(".mp4"):
        new_name = to_snake_case(item)
        dest_path = os.path.join(dest_dir, new_name)
        
        print(f"Processing '{item}' -> '{new_name}'")
        shutil.copy2(source_path, dest_path)
        
        # Create a readable title from the original filename
        title = os.path.splitext(item)[0]
        # Clean up title simply by removing extension, maybe capitalization is already good in source
        
        songs.append({
            "title": title,
            "filename": new_name,
            "path": f"assets/video/sing_along/{new_name}"
        })

print("MIGRATION_RESULT_START")
print(json.dumps(songs, indent=2))
print("MIGRATION_RESULT_END")
