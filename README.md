# Automatic CLI replayer/GIF recorder/demo tool

This repo is a combination of tools to make it easy to replay CLI commands and record CLI gifs from your terminal.

Never again fat finger a command in a live demo and have to retype it!

Never again record a bunch of helpful commands, only to realize you forgot to record something in the middle, or that you made a typo somewhere and then have to painstakingly re-record everything!

Prereqs:

- [`just`](https://github.com/casey/just) - a command runner
- [`ttyrec`]() - a terminal recorder
- [`ttygif`]() - a terminal to gif converter

`just`, `ttyrec`, and `ttygif` are all available via homebrew on macos, install with:

```sh
$ brew install just ttyrec ttygif
```

*Note: `just` is not strictly required. It's a task runner and you can run the commands directly if necessary.*

## How to use this repo?

This is meant to be a boilerplate project that you fork and maintain for your own purposes. It can be a source of documentation, tests, and examples for your CLI tools.

## Installation

Clone this repo

```
$ git clone github.com/jsoverson/auto-cli-gif
```

## Usage

1) First, initialize submodules to get the `demo-magic` script

```
$ just init
```

2) Add scripts to the `scripts/` directory

3) Play!

Use `just run` to run a script without recording it. This is useful for live demos where you want to guarantee that the script will run without errors.

For example:

```sh
$ just run scripts/hello-world.sh
```

4) Record!

Use just record to run a script, record it, then convert it into a GIF.

```sh
$ just record scripts/hello-world.sh
```

5) View your recordings in the `recordings/` directory

![Recording of echo "Hello, World!"](recordings/hello-world.sh.gif "Recording of echo 'Hello, World!'")


## Recording everything at once.

If your primary motivation is recording CLI animations, you can use `just record-all` to record all scripts in the `scripts/` directory.

```sh
$ just record-all
```

## Customization

Edit the `src/SCRIPT_SETUP.sh` or the `src/SCRIPT_TEARDOWN.sh` files to customize what runs before and after every script in `scripts/`

Typically you'll want to setup the prompt and typing speed and end your recordings in a consistent way. This is where you'll do it.

## Debugging

Run `just debug` to see your commands execute without being recorded or turned into a GIF.

```sh
$ just debug scripts/hello-world.sh
```


## FAQ

### How can I simulate typing?
### What is `pei`?
### What is `demo-magic`?

This repo uses the awesome `demo-magic` script from [paxtonhare/demo-magic](https://github.com/paxtonhare/demo-magic) to simulate typing and other useful effects.

Check out the [demo-template](https://github.com/paxtonhare/demo-magic/blob/master/samples/demo-template.sh) for more tips.

### I get a lot of shell/autocomplete/other noise

It's best to use a terminal profile that is as close to default settings as possible. That means starting up a shell that typically doesn't source rc settings.

This is different for every terminal emulator, but is usually as simple as using your default shell without rc files (e.g. `zsh -d -f` ) and sourcing a custom, recording-oriented configuration file (e.g. `source ~/.zshrc-recording`).

Terminal emulators like `iterm2` support this well with their "Profiles" feature.

### My terminal isn't resizing, what do I do?

If you're using iterm2, you need to disable a default setting:

![Uncheck disable session-initiated window resizing](docs/iterm2-resizing.png "Uncheck disable session-initiated window resizing")

If you're using another terminal, you probably need to find a similar setting. The `resize` function uses standard shell escapes to resize the terminal.

### How do I stop the iterm2 titlebar from showing the different commands?

Add this to your .zshrc

```sh
function title {
    echo -ne "\033]0;"$*"\007"
}

title "terminal"⏎
```