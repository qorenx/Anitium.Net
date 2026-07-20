İnstall

Requirements

Node.js 20+(22 Pref)

İnstall=>

Run= npm i
(Node Pack  Download^^)

Run= npm run start


Need Change:
package.json

Edit=>
    "start": "HOSTNAME=0.0.0.0 PORT=3000 node server.js",
    "preview": "HOSTNAME=0.0.0.0 PORT=3000 node server.js"
	
Badgate=> 
If you get an error, change the text 0.0.0.0 to localhost. Or change the server IP? Or change it. I'm not sure which VPS you're using. Note:

npm warn config production Use `--omit=dev` instead.
> anitium-hosting@0.0.0 start
> HOSTNAME=0.0.0.0 PORT=3000 node server.js
▲ Next.js 16.3.0-preview.3
- Local: http://localhost:3000
- Network: http://0.0.0.0:3000
✓ Ready in 0ms

It works when you get output like the above. But if you still can't access it, and you see different text like "qwgqwg4" or other things in the local or network section, it means there's a problem with the settings somewhere on the VPS... or the package installer.


Domain & Access Rules
The system only allows usage from the following domains:
localhost/
anitium.net/
anisora.fun/

Register=> 

discord.gg/YmDHnQGxCn/


Domain Setup & Admin Paths
To configure or manage domains, use the following routes:
domain.com/setup

superadmin register: 
domain.com/admin/setup

When you add a domain via Discord, the repository is updated. You can use the system domain. You need to upload every 30 days. This will be extended to 1 year in the future. For now, you need to update it for testing purposes.


Note: This is similar to Nixpacks. If you create a repository and repository every time Github receives updates, the data in the public folder is reset. Therefore, the slider or anime poster you added may not display. For this reason, I recommend creating a static package repository. I will add an external entry for posters, etc., in the future. It would be beneficial to pay attention to this process.

