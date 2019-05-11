#include <iostream>
#include <algorithm>
#include <functional>
#include "SDL.h"

int main() {
  std::cout << "Loading..." << std::endl;

  SDL_Window *window = NULL;
  SDL_Renderer *renderer = NULL;
  SDL_Texture *bitmapTexture = NULL;
  SDL_Surface *bitmapSurface = NULL;

  int windowWidth = 640, windowHeight = 480;
  
  SDL_Init(SDL_INIT_VIDEO);

  window = SDL_CreateWindow(
      "Test Game",
      SDL_WINDOWPOS_UNDEFINED,
      SDL_WINDOWPOS_UNDEFINED,
      windowWidth,
      windowHeight,
      SDL_WINDOW_OPENGL);

  renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

  bitmapSurface = SDL_LoadBMP("./image.bmp");
  bitmapTexture = SDL_CreateTextureFromSurface(renderer, bitmapSurface);

  if (window == NULL) {
    std::cout << "Couldn't open window!" << std::endl;
    return 1;
  }

  while (true) {
    SDL_Event currentEvent;
    if (SDL_PollEvent(&currentEvent)) {
      if (currentEvent.type == SDL_QUIT) { break; }
    }

    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, bitmapTexture, NULL, NULL);
    SDL_RenderPresent(renderer);
  }

  SDL_DestroyTexture(bitmapTexture);
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  
  SDL_Quit();
  
  return 0;
}


// Local Variables:
// compile-command: "clang++ -Wall ./sdl2-test.cpp -o test-game `sdl2-config --cflags --libs` && ./test-game"
// End:
