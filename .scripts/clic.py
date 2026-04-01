import evdev
import pygame
import os

# Configuration
USER = "athena"
BASE_PATH = f"/home/{USER}/.config/wayclick/audio_pack_1/"

# Initialisation du moteur audio Pygame
pygame.mixer.init(frequency=44100, size=-16, channels=2, buffer=256) # Buffer très petit = latence basse

# Pré-chargement et réglage du volume (0.0 à 1.0)
VOL = 0.4

# Pré-chargement des sons en mémoire (RAM)
SOUND_FILES = {
    'KEY_ENTER': pygame.mixer.Sound(os.path.join(BASE_PATH, 'ent.wav')),
    'KEY_SPACE': pygame.mixer.Sound(os.path.join(BASE_PATH, 'space1.wav')),
    'KEY_BACKSPACE': pygame.mixer.Sound(os.path.join(BASE_PATH, 'back.wav')),
    'DEFAULT': pygame.mixer.Sound(os.path.join(BASE_PATH, 'key1.wav'))
}

# Application du volume à chaque son
for 	sound in SOUND_FILES.values():
	sound.set_volume(VOL)

def start_clicking():
    devices = [evdev.InputDevice(path) for path in evdev.list_devices()]
    kbd = next((d for d in devices if d.name == "AT Translated Set 2 keyboard"), None)

    if not kbd:
        print("Clavier non trouvé.")
        return

    print(f"⚡ Mode Ultra-Low Latency activé sur : {kbd.name}")

    for event in kbd.read_loop():
        if event.type == evdev.ecodes.EV_KEY and event.value == 1:
            key_name = evdev.ecodes.keys.get(event.code, 'DEFAULT')
            # On joue le son instantanément depuis la RAM
            sound = SOUND_FILES.get(key_name, SOUND_FILES['DEFAULT'])
            sound.play()

if __name__ == "__main__":
    start_clicking()
