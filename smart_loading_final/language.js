let userLang = navigator.language || navigator.userLanguage;
if (userLang.startsWith("nl")) {
    document.documentElement.lang = "nl";
} else if (userLang.startsWith("fr")) {
    document.documentElement.lang = "fr";
} else {
    document.documentElement.lang = "en";
}
