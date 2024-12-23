import os
import re
import shutil
import logging


def organize_episodes(root_folder, destination_root, dry_run=False):
    # Configure logging
    logging.basicConfig(level=logging.INFO, format="%(message)s")

    # Define known movie file formats
    movie_extensions = [".avi", ".mp4", ".mkv", ".mov", ".wmv"]

    for folder_name in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder_name)
        if os.path.isdir(folder_path):
            match = re.match(r"(.+)\.S(\d+)E(\d+)\.(.+)", folder_name)
            if match:
                (
                    series_name,
                    season_number,
                    episode_number,
                    episode_name,
                ) = match.groups()
                series_name = series_name.replace(
                    ".", " "
                )  # Replace periods with spaces in the series name
                season_folder = os.path.join(
                    destination_root, series_name, f"Season {int(season_number)}"
                )

                if not dry_run:
                    os.makedirs(season_folder, exist_ok=True)

                for file_name in os.listdir(folder_path):
                    file_path = os.path.join(folder_path, file_name)
                    if os.path.isfile(file_path):
                        _, extension = os.path.splitext(file_name)
                        if extension.lower() in movie_extensions:
                            new_file_name = f"{series_name} S{season_number.zfill(2)}E{episode_number.zfill(2)} {episode_name.replace('.', ' ')}{extension}"
                            new_file_path = os.path.join(season_folder, new_file_name)

                            if dry_run:
                                logging.info(
                                    f"[DRY RUN] Would copy {file_name} to {new_file_path}"
                                )
                            else:
                                shutil.copy2(file_path, new_file_path)
                                logging.info(f"Copied {file_name} to {new_file_path}")
                        else:
                            if dry_run:
                                logging.info(
                                    f"[DRY RUN] Would delete {file_name} (unsupported format)"
                                )
                            else:
                                os.remove(file_path)
                                logging.info(
                                    f"Deleted {file_name} (unsupported format)"
                                )

                if dry_run:
                    logging.info(f"[DRY RUN] Would remove empty folder: {folder_path}")
                else:
                    shutil.rmtree(folder_path)
                    logging.info(f"Removed empty folder: {folder_path}")


# Usage example
root_folder = "/mnt/server/i/downloads/TV/"
destination_root = "/mnt/server/i/downloads/ORG_TV/"
dry_run = False  # Set to False to perform actual file operations

organize_episodes(root_folder, destination_root, dry_run)
