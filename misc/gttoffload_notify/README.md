# GTT Offload Notify
## Description
A temporary bash script I made for our GSK POP to notify us on when GSK pushes policies to GTT to offload single `/32` IPs on our network. This happens when GSK detects a (D)DoS attack. It then sends a cURL POST request to a Discord Web Hook I made in GFL's internal Discord server to notify us for when an attack occurs.

This is somewhat unreliable, but a solution that works for right now. You will need to edit the bash file and modify the webhook URL along with the group ID (note - `%26` represents the `&` character in the message contents for a role mention).