<h1>The Challenge</h1>
This game was created as a part of the <a href="https://itch.io/jam/1-button-jam-2023">One Button Game Jam 2023</a> on Itch.io. The game jam's main goals were focused around accessibility and creative design to create a compelling game surrounding the idea of only using one button to control everything, including menu navigation.
The theme revealed on the day of the jam was focused around three words: PLAN/E, CHARGE, INVOKE.

With the theme and the challenge of the game jam, I decided to create a game focused on a charge mechanic, in which you hold down the singular button to charge a weapon and release the button to fire it. Subsequently, this led to the decision to make a fixed shooter that draws on inspiration from games like Galaga and Space Invaders. 
<br>
<h1>Planning</h1>
Developing a fixed shooter requires three main pieces:
<ol>
  <li>A varied set of enemies approaching from one side of the screen.</li>
  <li>A character on the opposite side of the screen that the player controls and fires from.</li>
  <li>Creative design that influences decision-making when the player is choosing where to fire.</li>
</ol>

Most fixed shooters have the enemies move from side to side as they approach the opposite side of the screen as them. Due to this, the player then must move their character and fire the weapons at the correct times to ensure that their often slow moving bullet hits the enemies in motion. However, due to the game jam's challenge of only using one button, I had to decide whether to make the button move the player while they automatically shoot, or charge the weapon and fire it while the player moves automatically. I focused on the latter option as it ended up feeling more engaging during playtesting. 

With these options in mind, I began to plan my development process for the full week that the jam was running. My inital goals were entirely focused around building a singular level with the charge mechanic implemented, and then if I had enough time, I would attempt to build out other levels. I predicted that it would take me about two days to implement menu navigation, pausing, and the charge mechanic using only one button. Then, I assumed a similar amount of time to create all of the necessary art pieces for just the player, the shots they fired, and the title screen. That left me with three days for playtesting and polish. 

I had already resolved to utilize the Godot Game Engine, as I am very interested in it as a development option for the future, and wanted to learn more about using the tool in an applicable situation. I had considered using Unity well before I decided on Godot in the past, but their recent to the time business decision of installation fees dissuaded me from pursuing utilizing the engine, despite its capabilities for 2D development. 

<h1>Debrief</h1>
<p>Development went smoothly and according to my initial schedule, however as a novice game developer, even a full three days at the end was not enough time to ensure I could polish out all of the bugs. The game is fully playable, however some players reported that the intended fanfare after you defeat the final boss does not play. Overall though, I am proud of my first game jam submission ever and my first real development cycle as a game developer. I learned a ton about how the physics and collision system works within Godot, and I learned how to troubleshoot bugs using the debugger and various playtesting options that Godot provides. I also was able to implement a creative solution for navigation, utilizing an ID system for buttons on each page, to allow the singular button to help the user navigate smoothly and fit the theme of "charging" on the button that is highlighted. 
</p>
<p>
If I were to do anything different, it would simply be that I would have liked to have been more familiar with the game engine I chose and the tools it provides. I know I was unable to use the engine to its fullest capabilities. Since submitting this game to the game jam, I have learned so much more about how menu options work in Godot. I believe I wouldn't have had to create a brand new ID system to navigate through the buttons on each page, instead using the shortcuts and built in functionality of buttons to use one button to navigate. Additionally, since this was my first time utilizing tags on nodes, I believe that's where the bug with the final boss lies, where one or two enemies might still "exist" which prevents the game from identifying that the fight is over. I would re-examine the code in the wave manager to identify why it is not detecting that the wave is over and to play the final fanfare. </p>

<p>Again though, I am proud of the work I was able to do for this game jam, especially without using any prefab assets, and only using free domain music to set the mood for the game. Having made my own art, programming all of the work myself, and coming up with my own concept, I feel very happy with what I was able to accomplish in a week.</p>
