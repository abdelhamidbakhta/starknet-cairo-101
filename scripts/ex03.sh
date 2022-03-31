# Load configuration
source $STARKNET_CAIRO_101_ROOT_DIR/scripts/.env

function get_counter() {
    echo "Reading counter value"
    cmd="starknet call --address $EX03_ADDR --abi $ABI_DIR/ex03.json"
    cmd="$cmd --network $NETWORK --account $ACCOUNT_ALIAS"
    cmd="$cmd --function user_counters"
    cmd="$cmd --inputs $ME"

    output=$(eval $cmd | tail -1)
    echo "My counter: $output"    
}

function increment_counter() {
    starknet invoke \
    --address $EX03_ADDR \
    --abi $ABI_DIR/ex03.json \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function increment_counter 
}

function decrement_counter() {
    starknet invoke \
    --address $EX03_ADDR \
    --abi $ABI_DIR/ex03.json \
    --network $NETWORK --account $ACCOUNT_ALIAS \
    --function decrement_counter 
}

while true; do
    select yn in "Get" "Increment" "Decrement" "Quit"; do
        case $yn in
            Get ) get_counter; break;;
            Increment ) increment_counter; break;;
            Decrement ) decrement_counter; break;;
            Quit ) exit;;
        esac
    done
done
