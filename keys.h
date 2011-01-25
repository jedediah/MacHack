#ifndef keys_H_
#define keys_H_

#define VK_ESCAPE          53
#define VK_F1             122
#define VK_F2             120
#define VK_F3              99
#define VK_F4             118
#define VK_F5              96
#define VK_F6              97
#define VK_F7              98
#define VK_F8             100
#define VK_F9             101
#define VK_F10            109
#define VK_F11            103
#define VK_F12            111
#define VK_F13            105
#define VK_F14            107
#define VK_F15            113

#define VK_BACKTICK           50
#define VK_ONE         18
#define VK_TWO         19
#define VK_THREE       20
#define VK_FOUR        21
#define VK_FIVE        23
#define VK_SIX         22
#define VK_SEVEN       26
#define VK_EIGHT       28
#define VK_NINE        25
#define VK_ZERO        29
#define VK_MINUS       27
#define VK_EQUALS      24
#define VK_DELETE      51

#define VK_TAB         48
#define VK_Q           12
#define VK_W           13
#define VK_E           14
#define VK_R           15
#define VK_T           17
#define VK_Y           16
#define VK_U           32
#define VK_I           34
#define VK_O           31
#define VK_P           35
#define VK_LBRACKET    33
#define VK_RBRACKET    30
#define VK_BACKSLASH   42

#define VK_CAPSLOCK    57
#define VK_SPECIAL_CAPSLOCK 127   // special caps key for TiBook (and probably other models)
#define VK_A            0
#define VK_S            1
#define VK_D            2
#define VK_F            3
#define VK_G            5
#define VK_H            4
#define VK_J           38
#define VK_K           40
#define VK_L           37
#define VK_SEMICOLON   41
#define VK_APOSTROPHE  39
#define VK_RETURN      36
#define VK_ENTER       52   // ??? never heard of this
#define VK_POWERBOOKG4_2005_ENTER 76

#define VK_SHIFT       56   // left
#define VK_Z            6
#define VK_X            7
#define VK_C            8
#define VK_V            9
#define VK_B           11
#define VK_N           45
#define VK_M           46
#define VK_COMMA       43
#define VK_PERIOD      47
#define VK_SLASH       44
#define VK_SHIFT_R     60

#define VK_FN          63
#define VK_CONTROL     59
#define VK_OPTION      58
#define VK_COMMAND     55
#define VK_SPACE       49
#define VK_COMMAND_R   54
#define VK_OPTION_R    61
#define VK_CONTROL_R   62

#define VK_HELP       116
#define VK_HOME       115
#define VK_PAGE_UP    116
#define VK_FORWARD_DELETE 117
#define VK_END        119
#define VK_PAGE_DOWN  121

#define VK_LEFT_ARROW  123
#define VK_RIGHT_ARROW 124
#define VK_DOWN_ARROW  125
#define VK_UP_ARROW    126

#define VK_NUM_LOCK    71
#define VK_NUMPAD_EQUALS   81
#define VK_NUMPAD_SLASH    75
#define VK_NUMPAD_ASTERISK 67
#define VK_NUMPAD_SEVEN    89
#define VK_NUMPAD_EIGHT    91
#define VK_NUMPAD_NINE     92
#define VK_NUMPAD_MINUS    78
#define VK_NUMPAD_FOUR     86
#define VK_NUMPAD_FIVE     87
#define VK_NUMPAD_SIX      88
#define VK_NUMPAD_PLUS     69
#define VK_NUMPAD_ONE      83
#define VK_NUMPAD_TWO      84
#define VK_NUMPAD_THREE    85
#define VK_NUMPAD_ENTER    76
#define VK_NUMPAD_ZERO     82
#define VK_NUMPAD_DOT      65

#define VK_BRIGHTNESS_DOWN		10
#define VK_BRIGHTNESS_UP		9
#define VK_VOLUME_MUTE		8
#define VK_VOLUME_DOWN		7
#define VK_VOLUME_UP		6

#define VK_EJECT	11

#define VK_MAX_COUNT 128

#define VK_FLAG_SHIFT 0x40000000
#define VK_FLAG_CTRL  0x20000000

extern int CharToKeyCode[];

#endif // keys_H_
