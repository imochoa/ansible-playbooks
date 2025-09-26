change all keyboard shortcuts

# Firefox autoconfig.js
https://support.mozilla.org/en-US/questions/1378404#answer-1510431
https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig


    on Windows and Linux, they go into the same directory where Firefox is installed
    on macOS, they go into the Contents/Resources directory of the Firefox.app 


 autoconfig.js, and it must be placed into the defaults/pref directory. It should contain the following two lines:

pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
