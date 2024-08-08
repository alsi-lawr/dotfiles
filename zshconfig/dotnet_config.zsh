# ---- dotnet tools & path ----
alias dot-tool-install="dotnet tool install --tool-path $SHARED_CONF/.dotnet/tools"
export DOTNET_ROOT=/usr/share/dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$SHARED_CONF/.dotnet/tools
