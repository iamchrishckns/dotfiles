#!/usr/bin/env bash

PS3="Select setup"

setups=(
    "Personal Mac Studio (5x)"
    "Work MacBook Air (4x)"
)

echo "Please select the display setup you want to apply:"

for i in "${!setups[@]}"; do
    echo "$((i + 1)). ${setups[i]}"
done

echo ""
read -rp "Enter your choice [1-${#setups[@]}]: " choice

case $choice in
    [1-2])
        setup="${setups[$((choice - 1))]}"
        
        if ! command -v displayplacer &> /dev/null; then
            echo "displayplacer is not installed. Please install it first."
            exit 1
        fi

        echo ""
        echo "Applying configuration: $setup"
        echo ""

        case $setup in
            "Personal Mac Studio (5x)")
                displayplacer "id:36BAE670-845D-4DD7-A061-E9CA655FB5D2 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0" "id:FF15AC29-0188-45F6-882A-CDEC25805659 res:1440x2560 hz:144 color_depth:8 enabled:true scaling:off origin:(2560,-950) degree:270" "id:0CFB62F7-708D-4A7E-B9FA-E39AC122FF9A res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(-2770,-1440) degree:180" "id:2F0405B1-C2AA-403B-B663-38B10F60393F res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(0,-1440) degree:180" "id:E1078DDE-2593-4EF9-B24D-63AE4A4EC407 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(-2560,0) degree:0"

                echo "Configuration '${setup}' applied."
                ;;
            "Work MacBook Air (4x)")
                echo "Not yet configured"

                echo "Configuration '${setup}' applied."
                ;;
            *)
                echo "Invalid option $REPLY";;
        esac
        ;;
    *)
        echo "Invalid option $REPLY";;
esac
