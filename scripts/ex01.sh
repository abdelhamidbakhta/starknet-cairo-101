# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

starknet invoke \
--address $EX01_ADDR \
--abi $ABI_DIR/ex01.json \
--network $NETWORK --account $ACCOUNT_ALIAS \
--function claim_points