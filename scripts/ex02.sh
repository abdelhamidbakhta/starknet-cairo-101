# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

echo "Reading secret value through getter function"
cmd="starknet call --address $EX02_ADDR --abi $ABI_DIR/ex02.json"
cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
cmd="$cmd --function my_secret_value"

output=$(eval $cmd | tail -1)
echo "Secret value: $output"

echo "Invoking claim_points with secret value"
starknet invoke \
--address $EX02_ADDR \
--abi $ABI_DIR/ex02.json \
--network $NETWORK --account $ACCOUNT_ALIAS \
--function claim_points \
--inputs $output