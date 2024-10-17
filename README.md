# SecureServe - Advanced Free Open Source FiveM Anti-Cheat

SecureServe is a comprehensive and advanced anti-cheat solution for FiveM, designed to keep your server secure and ensure a fair gameplay environment. This project is completely free and open-source.

## Developer Branch
In here you will see the code organized and decompiled it will still works but not recommended to run at this sate.

running in this state will cause security problems and will add breaches to the anticheat security.

it's full developer mode means bans are only logged and prints are added for every system.

![SecureServe Preview](https://github.com/user-attachments/assets/37b39ce0-a7ee-4ac1-a9c7-6033c086ce9b)

## Key Features
- **Anti Internal** (temporarily removed, will return soon after optimization).
- Detection of unauthorized triggers with detailed event logging.
- Configurable whitelisted events to prevent false bans.
- Advanced mouse position and movement detection for cheat identification.

### Main Detections
**Entities Detections**
- **Entities Detection**: Detects unauthorized entities created by cheats.
- **Triggers Detection**: Monitors and prevents unauthorized event triggers.
- **Resources Detection**: Identifies suspicious or unauthorized resources.
- **Internals Executors Detection**: Detects internal executors used for cheating.
- **Sounds Protections**: Prevents unauthorized sounds or audio manipulations.
- **Entity Control Protection**: Prevents control hijacking of server entities.
- **Safe Player**: Ensures players are protected from common exploits.

**Client-Side Detections**
- **Menu Detections**: Detects unauthorized cheat menus.
- **Noclip Detection**: Identifies players using noclip.
- **Freecam Detection**: Prevents unauthorized freecam usage.
- **Godmode Detection**: Detects invincibility or "godmode" cheats.
- **Rapidfire Detection**: Identifies rapid-fire exploits.
- **Norecoil Detection**: Detects removal of weapon recoil.
- **AI Files Detection**: Detects modified AI files used for cheating.

**Server-Side Detections**
- **Weapon Detection**: Monitors unauthorized weapons.
- **Particles Detection**: Identifies suspicious particle effects.
- **Explosions Detection**: Detects unauthorized explosions.
- **Stop Detection**: Prevents unauthorized stopping of server resources.

## Upcoming Updates
- **In-Game Admin Panel**: If we reach 40 stars on GitHub, the in-game admin panel will be released!
- Reintroducing **Anti Internal** with optimized performance.
  
## Installation Guide
1. Upon initial installation, you may see a ban reason:
   > "A player has been banned for Trigger Event with an executor (name of the event)"
2. To fix this issue, go to the configuration file.
3. Copy the name of the event causing the ban.
4. Add this event name to the **whitelisted events list** in the config.
5. This will resolve the issue caused by encrypted and decrypted scripts running the same events due to the encryption method used to prevent event triggering.

## Important Notes
- Please update the webhooks to avoid sending spam notifications to the developer.
- **Discord Support**: If you have any questions or need help, join our [Discord Server](https://discord.gg/z6qGGtbcr4).
- Check out our **video previews**:
  - [First Perivew](https://www.youtube.com/watch?v=xgFFfGNQehk)
  - [Second Perview](https://youtu.be/BfSHgVtE3eE)

## Contributing
We welcome contributions from the community! If you would like to report issues, suggest features, or contribute code, please feel free to create a pull request or start a discussion.

## Disclaimer
**Anti Internal** has been temporarily removed due to high MS usage but will be added again soon after further optimization. We are using mouse position and movement tracking to detect cheats, and this code will be uploaded soon.

## License
SecureServe is released under the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.en.html). Feel free to use, modify, and distribute it as per the terms of the license.

## Contact
- **Discord**: [Join our server](https://discord.gg/z6qGGtbcr4) to connect with the developer and the community.

## Goals
- **40 GitHub Stars**: Release of the in-game admin panel upon reaching the milestone.

### Enjoy a secure FiveM experience with SecureServe!
