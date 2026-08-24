// Copyright (c) 2026 opx. All rights reserved.

const opxMauiColor = {
    parse: function (value) {
        const match = String(value ?? "").match(/rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)/i);
        if (!match) {
            return null;
        }

        return [
            Math.min(255, Number(match[1])),
            Math.min(255, Number(match[2])),
            Math.min(255, Number(match[3]))
        ];
    },
    toHex: function (rgb) {
        if (!rgb) {
            return "#ffffff";
        }

        return `#${rgb.map(part => part.toString(16).padStart(2, "0")).join("")}`;
    },
    usesLightContent: function (rgb) {
        if (!rgb) {
            return false;
        }

        const linear = rgb.map(part => {
            const channel = part / 255;
            return channel <= 0.04045
                ? channel / 12.92
                : Math.pow((channel + 0.055) / 1.055, 2.4);
        });
        const luminance = (0.2126 * linear[0]) + (0.7152 * linear[1]) + (0.0722 * linear[2]);
        return luminance < 0.42;
    }
};

window.opxMauiHost = {
    loadScript: function (source) {
        if (!source) {
            return Promise.reject(new Error("A script source is required."));
        }

        const existing = document.querySelector(`script[data-opx-flat-ui-source="${source}"]`);
        if (existing) {
            return existing.dataset.loaded === "true"
                ? Promise.resolve()
                : new Promise((resolve, reject) => {
                    existing.addEventListener("load", resolve, { once: true });
                    existing.addEventListener("error", reject, { once: true });
                });
        }

        return new Promise((resolve, reject) => {
            const script = document.createElement("script");
            script.src = source;
            script.dataset.opxFlatUiSource = source;
            script.addEventListener("load", () => {
                script.dataset.loaded = "true";
                resolve();
            }, { once: true });
            script.addEventListener("error", reject, { once: true });
            document.body.appendChild(script);
        });
    },
    getAppBarAppearance: function () {
        const appBar = document.querySelector(".monitor-header");
        const rgb = appBar
            ? opxMauiColor.parse(getComputedStyle(appBar).backgroundColor)
            : null;

        return {
            backgroundColor: opxMauiColor.toHex(rgb),
            useLightContent: opxMauiColor.usesLightContent(rgb)
        };
    },
    applyTransparentStatusBarLayout: function (topInsetPx, appBarColor) {
        const inset = Number.isFinite(Number(topInsetPx))
            ? Math.max(0, Math.min(96, Number(topInsetPx)))
            : 0;
        const root = document.documentElement;

        root.style.setProperty("--opx-native-statusbar-height", `${inset}px`);
        root.style.setProperty("--opx-native-appbar-color", appBarColor || "#ffffff");
        root.classList.toggle("opx-native-transparent-statusbar", inset > 0);
    }
};
