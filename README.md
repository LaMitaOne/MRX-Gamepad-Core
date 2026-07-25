# MRX-Gamepad-Core
A modern, lightweight gamepad input handler for Delphi using FireMonkey (FMX) and SDL3. It features a background polling thread, visual UI mapping, deadzone configuration, and rumble support.

🎮 MRX Gamepad Core (Delphi / FMX / SDL3) alpha v0.1    
     
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/LaMitaOne/MRX-Gamepad-Core)    
     
Status: 🚧 Work in Progress / Prototype. Core functionality works, but API might change.    
Sure some to do still, but a good start :)   
    
Guaranteed bugs to play with :D     
    
<img width="1318" height="795" alt="Unbenannt" src="https://github.com/user-attachments/assets/dd60a810-3fc8-4b65-84f9-ac87a1d5db9c" />
      
✨ Features

    SDL3 Dynamic Binding: No static .lib files needed. Just drop the SDL3.dll next to your .exe.
    Threaded Polling: Runs input detection in a background thread to keep your UI smooth.
    Thread-Safe Events: Gamepad events are safely marshaled to the main UI thread using TThread.Queue.
    Multi-Gamepad Support: Supports up to 4 connected gamepads simultaneously.
    Rumble Support: Trigger haptic feedback (low/high frequency motors) for any connected pad.
    Visual Settings UI: 
        Drag-and-drop style click-to-map interface for buttons.
        Visualizes analog stick movement directly on the UI.
        Adjustable Deadzones with visual indicators.
    Profile Management: Save and load controller mappings to .ini files.
    Event Throttling: Optimized to prevent event flooding from analog stick micro-movements.

📦 Requirements

    Delphi 10.x or newer (uses modern generics and anonymous threads).
    FireMonkey (FMX) framework.
    SDL3.dll (Place it in your project's output directory).

🚀 Sample Project    
   Project and compiled .exe are included in this repository. Tested with win32 and win64 and following controllers:    

    XInput: EasySMX X05 Pro
    DInput: EasySMX ESM-9124

🗺️ Todos

     Fix gamepad hot-plugging (disconnect/reconnect handling).
     Implement a proper data dictionary for mappings (instead of parsing UI label text).
     Add separate trigger deadzones.
     And many more sure :D

🤝 Contributing

This is a work in progress. If you find bugs or want to improve the code (especially the SDL3 pointer logic), feel free to open a Pull Request or an Issue!
📜 License

MIT License. See LICENSE file for details. 
(Note: SDL3 itself is licensed under the zlib license).

SDL3 from: [https://github.com/libsdl-org/SDL](https://github.com/libsdl-org)      

   
If you want to tip me a coffee.. :)   
    
<p align="center">
  <a href="https://www.paypal.com/donate/?hosted_button_id=RX5KTTMXW497Q">
    <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" alt="Donate with PayPal"/>
  </a>
</p>
        

