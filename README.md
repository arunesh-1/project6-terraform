# Project 10: Internal DNS Setup

An isolated Docker lab runs a dnsmasq DNS server at `172.30.10.10` and a web server at `172.30.10.20`. The DNS A record maps `app.training.test` to the web server. A separate client queries that DNS server with `nslookup`, then accesses the app at `http://app.training.test:8000/`.

This environment blocks DNS traffic on port 53, including loopback queries, so the DNS server uses port 1053. The client verifies the A record with `nslookup -type=A -port=1053 app.training.test 172.30.10.10`, obtains the address with `dig`, then supplies that DNS-returned address to `curl --resolve`. This proves DNS and HTTP access but does not demonstrate automatic operating-system hostname resolution.

## Run

Install Docker and use a Bash terminal (Linux, macOS, or WSL on Windows):

```sh
bash run-lab.sh
```

The script builds the images, prints actual DNS and HTTP results, and removes its containers and network when finished. Images remain available for reuse. It exits with an error if DNS resolution or HTTP access fails.

The `172.30.10.0/24` subnet must not overlap an existing network. The private Docker network has no published ports and does not change your computer's DNS settings. The hostname works only inside this lab, not in your host browser.

`nslookup-proof.txt` contains the captured test output.
