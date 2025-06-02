# Cameek.W3CssJs.Phaser

![NuGet](https://img.shields.io/nuget/v/Cameek.W3CssJs.Phaser?label=NuGet\&logo=nuget)
![.NET](https://img.shields.io/badge/.NET-8.0-blue?logo=dotnet)

**Cameek.W3CssJs.Phaser** is a Razor Class Library (RCL) providing static assets (JavaScript) for [Phaser](https://phaser.io/), a popular HTML5 game framework. It makes it simple to add high-performance 2D games and interactive visualizations to your Blazor WebAssembly and Blazor Server applications.

---

## ✨ Features

* Ships **Phaser 3.9.0** minified JS
* Easy integration for building 2D games and interactive experiences in Blazor
* Hosted under `_content/Cameek.W3CssJs.Phaser` for straightforward referencing in Blazor apps
* Ideal for educational, experimental, and commercial Blazor projects needing advanced JS game engines

---

## 📦 Installation

Install from NuGet:

```bash
dotnet add package Cameek.W3CssJs.Phaser --version 3.9.0
```

Or reference directly in your `.csproj`:

```xml
<PackageReference Include="Cameek.W3CssJs.Phaser" Version="3.9.0" />
```

---

## 🛠 Usage

In your `index.html` (Blazor WebAssembly) or `_Host.cshtml` (Blazor Server), include Phaser asset:

```html
<script src="_content/Cameek.W3CssJs.Phaser/js/phaser.min.js"></script>
```

### Example Usage

Create a basic Phaser scene using JS interop:

**wwwroot/scripts/phaser-demo.js**

```js
window.createPhaserGame = function (elementId) {
    new Phaser.Game({
        type: Phaser.AUTO,
        width: 400,
        height: 300,
        parent: elementId,
        scene: {
            create: function () {
                this.add.text(100, 140, "Hello Phaser!", { font: "24px Arial", fill: "#0099ff" });
            }
        }
    });
};
```

**In your Blazor component:**

```razor
@inject IJSRuntime JS

<div id="phaserGame"></div>

@code {
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            await JS.InvokeVoidAsync("createPhaserGame", "phaserGame");
        }
    }
}
```

---

## 💡 Tip: Blazor JS Interop

Wrap your Phaser startup code in a JS function and call it from Blazor for best results.
You can also manage Phaser scenes and assets from your Blazor components with custom interop methods.

---

## 📄 License

Phaser is licensed under the MIT License. See the [LICENSE-phaser.txt](https://github.com/photonstorm/phaser/blob/v3.9.0/license.txt) file included in this package for details.

---

## 👤 Author

Created and maintained by [CameekOrg](https://github.com/cameekorg). This project is intended for use across internal Cameek solutions.

---

## 📬 Related Projects

* [Cameek.W3CssJs.Gsap](https://www.nuget.org/packages/Cameek.W3CssJs.Gsap) – GSAP animation RCL for Blazor
* [Phaser](https://phaser.io/) – The fast, robust HTML5 game framework
