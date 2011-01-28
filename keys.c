#include <ApplicationServices/ApplicationServices.h>
#include "keys.h"

int CharToKeyCode[] = {
  VK_SPACE | VK_FLAG_CTRL,
  VK_A | VK_FLAG_CTRL,
  VK_B | VK_FLAG_CTRL,
  VK_C | VK_FLAG_CTRL,
  VK_D | VK_FLAG_CTRL,
  VK_E | VK_FLAG_CTRL,
  VK_F | VK_FLAG_CTRL,
  VK_G | VK_FLAG_CTRL,
  VK_DELETE,
  VK_TAB,
  VK_J | VK_FLAG_CTRL,
  VK_K | VK_FLAG_CTRL,
  VK_L | VK_FLAG_CTRL,
  VK_RETURN,
  VK_N | VK_FLAG_CTRL,
  VK_O | VK_FLAG_CTRL,
  VK_P | VK_FLAG_CTRL,
  VK_Q | VK_FLAG_CTRL,
  VK_R | VK_FLAG_CTRL,
  VK_S | VK_FLAG_CTRL,
  VK_T | VK_FLAG_CTRL,
  VK_U | VK_FLAG_CTRL,
  VK_V | VK_FLAG_CTRL,
  VK_W | VK_FLAG_CTRL,
  VK_X | VK_FLAG_CTRL,
  VK_Y | VK_FLAG_CTRL,
  VK_Z | VK_FLAG_CTRL,
  VK_ESCAPE,
  VK_BACKSLASH | VK_FLAG_CTRL,
  VK_RBRACKET | VK_FLAG_CTRL,
  VK_6 | VK_FLAG_SHIFT | VK_FLAG_CTRL,
  VK_MINUS | VK_FLAG_SHIFT | VK_FLAG_CTRL,
  
  VK_SPACE,
  VK_1 | VK_FLAG_SHIFT,
  VK_APOSTROPHE | VK_FLAG_SHIFT,
  VK_3 | VK_FLAG_SHIFT,
  VK_4 | VK_FLAG_SHIFT,
  VK_5 | VK_FLAG_SHIFT,
  VK_7 | VK_FLAG_SHIFT,
  VK_APOSTROPHE,
  VK_9 | VK_FLAG_SHIFT,
  VK_0 | VK_FLAG_SHIFT,
  VK_8 | VK_FLAG_SHIFT,
  VK_EQUALS | VK_FLAG_SHIFT,
  VK_COMMA,
  VK_MINUS,
  VK_PERIOD,
  VK_SLASH,
  VK_0,
  VK_1,
  VK_2,
  VK_3,
  VK_4,
  VK_5,
  VK_6,
  VK_7,
  VK_8,
  VK_9,
  VK_SEMICOLON | VK_FLAG_SHIFT,
  VK_SEMICOLON,
  VK_COMMA | VK_FLAG_SHIFT,
  VK_EQUALS,
  VK_PERIOD | VK_FLAG_SHIFT,
  VK_SLASH | VK_FLAG_SHIFT,
 
  VK_2 | VK_FLAG_SHIFT,
  VK_A | VK_FLAG_SHIFT,
  VK_B | VK_FLAG_SHIFT,
  VK_C | VK_FLAG_SHIFT,
  VK_D | VK_FLAG_SHIFT,
  VK_E | VK_FLAG_SHIFT,
  VK_F | VK_FLAG_SHIFT,
  VK_G | VK_FLAG_SHIFT,
  VK_H | VK_FLAG_SHIFT,
  VK_I | VK_FLAG_SHIFT,
  VK_J | VK_FLAG_SHIFT,
  VK_K | VK_FLAG_SHIFT,
  VK_L | VK_FLAG_SHIFT,
  VK_M | VK_FLAG_SHIFT,
  VK_N | VK_FLAG_SHIFT,
  VK_O | VK_FLAG_SHIFT,
  VK_P | VK_FLAG_SHIFT,
  VK_Q | VK_FLAG_SHIFT,
  VK_R | VK_FLAG_SHIFT,
  VK_S | VK_FLAG_SHIFT,
  VK_T | VK_FLAG_SHIFT,
  VK_U | VK_FLAG_SHIFT,
  VK_V | VK_FLAG_SHIFT,
  VK_W | VK_FLAG_SHIFT,
  VK_X | VK_FLAG_SHIFT,
  VK_Y | VK_FLAG_SHIFT,
  VK_Z | VK_FLAG_SHIFT,
  VK_LBRACKET,
  VK_BACKSLASH,
  VK_RBRACKET,
  VK_6 | VK_FLAG_SHIFT,
  VK_MINUS | VK_FLAG_SHIFT,
  
  VK_BACKTICK,
  VK_A,
  VK_B,
  VK_C,
  VK_D,
  VK_E,
  VK_F,
  VK_G,
  VK_H,
  VK_I,
  VK_J,
  VK_K,
  VK_L,
  VK_M,
  VK_N,
  VK_O,
  VK_P,
  VK_Q,
  VK_R,
  VK_S,
  VK_T,
  VK_U,
  VK_V,
  VK_W,
  VK_X,
  VK_Y,
  VK_Z,
  VK_LBRACKET | VK_FLAG_SHIFT,
  VK_BACKSLASH | VK_FLAG_SHIFT,
  VK_RBRACKET | VK_FLAG_SHIFT,
  VK_BACKTICK | VK_FLAG_SHIFT,
  VK_FORWARD_DELETE
};


bool vkIsLetter(int key) {
  switch (key) {
    case VK_A:
    case VK_B:
    case VK_C:
    case VK_D:
    case VK_E:
    case VK_F:
    case VK_G:
    case VK_H:
    case VK_I:
    case VK_J:
    case VK_K:
    case VK_L:
    case VK_M:
    case VK_N:
    case VK_O:
    case VK_P:
    case VK_Q:
    case VK_R:
    case VK_S:
    case VK_T:
    case VK_U:
    case VK_V:
    case VK_W:
    case VK_X:
    case VK_Y:
    case VK_Z:
      return true;
      
    default:
      return false;
	}
}

bool vkIsNumber(int key) {
  switch(key) {
    case VK_0:
    case VK_1:
    case VK_2:
    case VK_3:
    case VK_4:
    case VK_5:
    case VK_6:
    case VK_7:
    case VK_8:
    case VK_9:
      return true;
      
    default:
      return false;
  }
}