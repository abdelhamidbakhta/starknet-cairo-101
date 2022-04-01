# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

# Summary
# invoke assign_user_slot
# invoke external_handler_for_internal_function 
# call user_values to read the copied value
# invoke claim_points with the value

EX=$EX06_ADDR
ABI="$ABI_DIR/ex06.json"

function user_slot() {
    echo "Reading my user slot"
    cmd="starknet call --address $EX --abi $ABI"
    cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
    cmd="$cmd --function user_slots"
    cmd="$cmd --inputs $ME"

    output=$(eval $cmd | tail -1)
    echo "My slot: $output"    
}

function read_value() {
    echo "Reading user value"
    cmd="starknet call --address $EX --abi $ABI"
    cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
    cmd="$cmd --function user_values"
    cmd="$cmd --inputs $ME"

    output=$(eval $cmd | tail -1)
    echo "Value: $output"    
}

function assign_user_slot() {
    starknet invoke \
    --address $EX \
    --abi $ABI \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function assign_user_slot
}

function external_handler_for_internal_function() {
    echo "Type the value: "
    read
    val=${REPLY}
    starknet invoke \
    --address $EX \
    --abi $ABI \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function external_handler_for_internal_function \
    --inputs $val
}

function claim_points() {
    val=$1
    starknet invoke \
    --address $EX \
    --abi $ABI \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function claim_points \
    --inputs $val
}

function process_claim_points() {
    echo "Type the value: "
    read
    val=${REPLY}
    echo "Claiming points with value: $val"
    claim_points $val
}


while true; do
    select yn in "Slot" "Read" "Assign" "Copy" "Claim" "Quit"; do
        case $yn in
            Slot ) user_slot; break;;
            Read ) read_value; break;;
            Assign ) assign_user_slot; break;;
            Copy ) external_handler_for_internal_function; break;;
            Claim ) process_claim_points; break;;
            Quit ) exit;;
        esac
    done
done
