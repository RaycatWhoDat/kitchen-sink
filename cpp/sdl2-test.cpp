#include <iostream>
#include <algorithm>
#include <functional>
#include "SDL.h"

SDL_Window *window = NULL;
SDL_Renderer *renderer = NULL;

int windowWidth = 640, windowHeight = 480;

enum KeyPress {
  KEY_PRESS_DEFAULT,
  KEY_PRESS_UP,
  KEY_PRESS_DOWN,
  KEY_PRESS_LEFT,
  KEY_PRESS_RIGHT,
  KEY_PRESS_TOTAL
};

int init() {
  std::cout << "Loading..." << std::endl;

  SDL_Init(SDL_INIT_VIDEO);

  window = SDL_CreateWindow(
      "Test Game",
      SDL_WINDOWPOS_UNDEFINED,
      SDL_WINDOWPOS_UNDEFINED,
      windowWidth,
      windowHeight,
      SDL_WINDOW_OPENGL);

  if (window == NULL) {
    std::cout << "Couldn't open window!" << std::endl;
    return 1;
  }

  renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
  return 0;
}

void update() {
  SDL_Texture *bitmapTexture = SDL_CreateTextureFromSurface(renderer, SDL_LoadBMP("./image.bmp"));

  bool isRunning = true;
  
  while (isRunning) {
    SDL_Event currentEvent;
    if (SDL_PollEvent(&currentEvent)) {
      if (currentEvent.type == SDL_QUIT) { break; }
      if (currentEvent.type == SDL_KEYDOWN) {
        switch (currentEvent.key.keysym.sym) {
          case SDLK_UP:
            std::cout << "Up" << std::endl;
            break;
          case SDLK_DOWN:
            std::cout << "Down" << std::endl;
            break;
          case SDLK_LEFT:
            std::cout << "Left" << std::endl;
            break;
          case SDLK_RIGHT:
            std::cout << "Right" << std::endl;
            break;
          case SDLK_q:
            SDL_Event quitEvent;
            quitEvent.type = SDL_QUIT;
            SDL_PushEvent(&quitEvent);
            break;
        }
      }
    }

    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, bitmapTexture, NULL, NULL);
    SDL_RenderPresent(renderer);
  }

  SDL_DestroyTexture(bitmapTexture);
}

void teardown() {
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  
  SDL_Quit();
}

int main() {
  init();
  update();
  teardown();

  return 0;
}


// Local Variables:
// compile-command: "clang++ -Wall ./sdl2-test.cpp -o test-game `sdl2-config --cflags --libs` && ./test-game"
// End:
