#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "forms.h"

void clean(void);
void buildMainForm(void);
void setupWindowMain(void);

MainForm mainForm;

int main() {
    newtInit();
    newtCls();
    atexit(&clean);
    
    newtCenteredWindow(100, 30, "Robot Main Window");
    int running = 1;
    while(running) {
        buildMainForm();
        newtFormRun(mainForm.form, &mainForm.ex);
        switch (mainForm.ex.reason) {
            case NEWT_EXIT_COMPONENT:
                if (mainForm.ex.u.co == mainForm.buttons.tools_btn) { setupWindowMain(); }
                if (mainForm.ex.u.co == mainForm.buttons.shutdown_btn) {running = 0; }
                break;
        }
    }
    return 0;
}

void clean() {
    newtFinished();
}

void buildMainForm() {
    mainForm.form = newtForm(NULL, NULL, 0);
    mainForm.buttons.tools_btn = newtButton(2, 1, " Setup  ");
    mainForm.buttons.shutdown_btn = newtButton(2, 26, "Shutdown");

    newtFormAddComponent(mainForm.form, mainForm.buttons.tools_btn);
    newtFormAddComponent(mainForm.form, mainForm.buttons.shutdown_btn);   
}

void buildSetupForm(void);

SetupForm setupForm;

void setupWindowMain() {
    newtCenteredWindow(40, 20, "Setup");
    buildSetupForm();
    int running = 1;
    while (running) {
        newtFormRun(setupForm.form, &setupForm.ex);
        if (setupForm.ex.reason == NEWT_EXIT_COMPONENT) {
            if (setupForm.ex.u.co == setupForm.done_btn) { running = 0; }
        }
    }
    newtPopWindow();
}

void buildSetupForm() {
    setupForm.form = newtForm(NULL, NULL, 0);
    setupForm.comCon.ent = newtEntry(13,1,"ttyS1", 6, NULL, NEWT_ENTRY_SCROLL);
    setupForm.comCon.lbl = newtLabel(1,1, "Serial Port:");
    setupForm.comCon.btn = newtCompactButton(20, 1, "Connect");
    setupForm.done_btn = newtButton(29, 15, "Done");

    newtFormAddComponent(setupForm.form, setupForm.comCon.ent);
    newtFormAddComponent(setupForm.form, setupForm.comCon.btn);
    newtFormAddComponent(setupForm.form, setupForm.comCon.lbl);
    newtFormAddComponent(setupForm.form, setupForm.done_btn);
}