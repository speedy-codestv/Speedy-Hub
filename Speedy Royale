import pygame
import random
import time
import sys
import json
import os

# Init
pygame.init()

# Game settings
WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
RED = (220, 20, 60)
BLUE = (30, 144, 255)
BLACK = (0, 0, 0)
FONT = pygame.font.SysFont("arial", 30)

screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Speedy Royale")

clock = pygame.time.Clock()

# Variables
score = 0
radius = 30
target_pos = (random.randint(radius, WIDTH - radius), random.randint(radius, HEIGHT - radius))
start_time = time.time()
power_up_active = False
power_up_timer = 0
game_time = 30  # seconds
end_time = time.time() + game_time
highscores_file = "speedy_highscores.json"

# Load leaderboard
if os.path.exists(highscores_file):
    with open(highscores_file, "r") as f:
        leaderboard = json.load(f)
else:
    leaderboard = []

# Draw
def draw_target(pos, color):
    pygame.draw.circle(screen, color, pos, radius)

def show_text(text, x, y, size=30):
    font = pygame.font.SysFont("arial", size)
    rendered = font.render(text, True, BLACK)
    screen.blit(rendered, (x, y))

def save_score(score):
    name = "Player"
    leaderboard.append({"name": name, "score": score})
    leaderboard.sort(key=lambda x: x["score"], reverse=True)
    leaderboard[:] = leaderboard[:5]
    with open(highscores_file, "w") as f:
        json.dump(leaderboard, f, indent=2)

def draw_leaderboard():
    show_text("🏆 Leaderboard:", 550, 20)
    for i, entry in enumerate(leaderboard):
        show_text(f"{i+1}. {entry['name']}: {entry['score']}", 550, 60 + i * 30)

# Game loop
running = True
game_over = False

while running:
    screen.fill(WHITE)

    if not game_over:
        draw_target(target_pos, BLUE if power_up_active else RED)
        draw_leaderboard()

        time_left = max(0, int(end_time - time.time()))
        show_text(f"Score: {score}", 10, 10)
        show_text(f"Time: {time_left}", 10, 50)

        if power_up_active and time.time() > power_up_timer:
            power_up_active = False

        if time_left <= 0:
            game_over = True
            save_score(score)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

            if event.type == pygame.MOUSEBUTTONDOWN:
                mx, my = pygame.mouse.get_pos()
                dist = ((mx - target_pos[0])**2 + (my - target_pos[1])**2) ** 0.5
                if dist <= radius:
                    reaction = time.time() - start_time
                    earned = max(1, int(5 - reaction)) * (2 if power_up_active else 1)
                    score += earned

                    # Random chance to trigger power-up
                    if random.random() < 0.2:
                        power_up_active = True
                        power_up_timer = time.time() + 5

                    target_pos = (random.randint(radius, WIDTH - radius), random.randint(radius, HEIGHT - radius))
                    start_time = time.time()

    else:
        show_text("⏱️ Time's up!", 300, 200, size=40)
        show_text(f"Final Score: {score}", 300, 250, size=36)
        show_text("Press R to play again or ESC to quit", 200, 320)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_r:
                    # Reset game
                    score = 0
                    end_time = time.time() + game_time
                    game_over = False
                elif event.key == pygame.K_ESCAPE:
                    running = False

    pygame.display.flip()
    clock.tick(60)

pygame.quit()
sys.exit()
