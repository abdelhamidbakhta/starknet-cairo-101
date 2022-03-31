# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

function user_slot() {
    echo "Reading my user slot"
    cmd="starknet call --address $EX05_ADDR --abi $ABI_DIR/ex05.json"
    cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
    cmd="$cmd --function user_slots"
    cmd="$cmd --inputs $ME"

    output=$(eval $cmd | tail -1)
    echo "My slot: $output"    
}

function read_value() {
    echo "Reading user value"
    cmd="starknet call --address $EX05_ADDR --abi $ABI_DIR/ex05.json"
    cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
    cmd="$cmd --function user_values"
    cmd="$cmd --inputs $ME"

    output=$(eval $cmd | tail -1)
    echo "Value: $output"    
}

function assign_user_slot() {
    starknet invoke \
    --address $EX05_ADDR \
    --abi $ABI_DIR/ex05.json \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function assign_user_slot
}

function copy_secret_value_to_readable_mapping() {
    starknet invoke \
    --address $EX05_ADDR \
    --abi $ABI_DIR/ex05.json \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function copy_secret_value_to_readable_mapping
}

function claim_points() {
    val=$1
    starknet invoke \
    --address $EX05_ADDR \
    --abi $ABI_DIR/ex05.json \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function claim_points \
    --inputs $val
}

function process_claim_points() {
    echo "Type the value: "
    read
    val=${REPLY}
    echo "Claiming points with value: $val"
    claim_points val
}


while true; do
    select yn in "Slot" "Value" "Read" "Assign" "Copy" "Claim" "Quit"; do
        case $yn in
            Slot ) user_slot; break;;
            Read ) read_value; break;;
            Assign ) assign_user_slot; break;;
            Claim ) process_claim_points; break;;
            Quit ) exit;;
        esac
    done
done
