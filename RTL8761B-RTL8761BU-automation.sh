#bin/bash

# Andrés Sánchez
# https://github.com/snchezz/

#Comprobamos que el directorio esta en la ruta donde se encuentra el Script, a la misma altura
bt=BT5.0_Linux
if [ -d "$bt" ]; then
    echo "El directorio BT5.0_Linux esta correctamente, porfavor pulsa cualquier letra para continuar:"
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

    echo "Todo ha salido correctamente"

    while true; do
        clear
        echo "Para que se apliquen los cambios y funcione, hay que reiniciar el equipo.
¿Quiere hacerlo ahora? S (Si) o N (No)"
        read confirmar
        case $confirmar in
        s | S | y | Y)
            read -n 1 -r -s -p $'Pulsa cualquier tecla para reiniciar el ordenador\n'
            reboot
            ;;
        n | N)
            clear
            echo "Deberas reiniciar a mano para que se confirmen los cambios"
            echo "Gracias por usar este script"
            exit
            ;;
        *)
            echo "No has pulsado una opcion valida"
            ;;
        esac
    done

else
    echo "El directorio BT5.0_Linux no existe, porfavor, compruebe que el archivo .sh y la carpeta se encuentran en la misma ruta"
    exit 1
fi
