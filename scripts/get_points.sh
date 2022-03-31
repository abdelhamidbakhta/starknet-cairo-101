# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

echo "Reading my score using balanceOf"
cmd="starknet call --address $POINTS_ADDR --abi $ABI_DIR/TDERC20.json"
cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
cmd="$cmd --function balanceOf --inputs $ME"

# Get the number of points in hexadecimal
output=$(eval $cmd | tail -1  | cut -d' ' -f1)
# Convert hex string to uppercase
output=$(eval cut -d "x" -f 2 <<< "$output" | tr '[:lower:]' '[:upper:]')
# Convert hex to decimal
points=$(echo "obase=10; ibase=16; $output" | bc)
# Truncate decimals
points=$(eval echo $points | awk '{ print substr( $0, 1, length($0)-18 ) }')
echo "Points: $points"