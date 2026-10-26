## NO SUPPORT INCLUDED  
I am keeping this plugin running as-is, no support or features will be added  

## Stop that Tank!

A unique game-mode that combines elements of Payload and Mann-Vs-Machine from Team Fortress 2.

* Check out the [**wiki**](https://github.com/akowald/StopThatTank/wiki) to get started.
* [Steam community group](https://steamcommunity.com/groups/StopThatTank).

## Building from source

```
scripts/build.sh             # writes build/tank.smx
scripts/build.sh --install   # also copies it to addons/sourcemod/plugins/
```

The script downloads the pinned SourceMod compiler and the pinned TF2Items include into `.build/`, then compiles `addons/sourcemod/scripting/tank.sp` with `spcomp64`. The pinned versions are at the top of the script, and the same script runs in GitHub Actions on every push and pull request, where the built `.smx` is uploaded as an artifact.

The native extension in `extension/` is a separate AMBuild project built against Metamod:Source. `scripts/build.sh` does not build it.
