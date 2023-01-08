#bin/bash

# Andrés Sánchez
# https://github.com/snchezz/

#Comprobamos que el directorio esta en la ruta donde se encuentra el Script, a la misma altura
bt=BT5.0_Linux
if [ -d "$bt" ]; then
    echo "The BT5.0_Linux directory is correct, please type any letter to continue:"
    read -n 1 -r -s -p $'\n'

    # Vamos al directorio del usb e instalamos
    cd BT5.0_Linux/20201202_LINUX_BT_DRIVER/usb
    sudo make install

    # Copiamos los archivos FW
    cd /lib/

    # Damos permiso al usuario para poder copiar archivos en la carpeta firmware
    quiensoy=$(whoami)
    sudo chown -R $quiensoy firmware
    cd ~
    pwd
    sudo cp BT5.0_Linux/20201202_LINUX_BT_DRIVER/rtkbt-firmware/lib/firmware/rtl8761bu_fw /lib/firmware/
    sudo cp BT5.0_Linux/20201202_LINUX_BT_DRIVER/rtkbt-firmware/lib/firmware/rtl8761bu_config /lib/firmware/

    echo "Everything went correctly"

    while true; do
        clear
        echo "For the changes to take effect and work, you have to restart your computer.
Do you want to do it now? Y (Yes) or N (No)"
        read confirmar
        case $confirmar in
        s | S | y | Y)
            read -n 1 -r -s -p $'Press any key to restart the computer \n'
            reboot
            ;;
        n | N)
            clear
            echo "You will have to restart manually for the changes to be confirmed"
            echo "Thank you for using this script"
            exit
            ;;
        *)
            echo "You did not press a valid option"
            ;;
        esac
    done

else
    echo "The directory BT5.0_Linux does not exist, please check that the .sh file and the folder are in the same path"
    exit 1
fi
