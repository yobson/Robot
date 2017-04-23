#include <newt.h>

///////////////////////
//      General      //
///////////////////////

struct entry {
    newtComponent ent;
    newtComponent lbl;
    newtComponent btn;
};

///////////////////////
//       Main        //
///////////////////////
struct MainFormButtons {
    newtComponent tools_btn;
    newtComponent shutdown_btn;
};

typedef struct {
    newtComponent form;
    struct newtExitStruct ex;
    struct MainFormButtons buttons;
} MainForm;


///////////////////////
//       Setup       //
///////////////////////

typedef struct {
    newtComponent form;
    struct newtExitStruct ex;
    struct entry comCon;
    newtComponent done_btn;
} SetupForm;

