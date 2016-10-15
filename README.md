1. Install [VirtualBox] (https://www.virtualbox.org/)
2. Install [Vagrant] (https://www.vagrantup.com/)
3. Clone this repository
4. Go to ```src``` directory and follow the [Magento download and unpack instructions] (src/magento/README.md)
5. Issue ```vagrant up``` command
6. Sleep, drink, watch TV until the virtual machine is completed ...
7. Add the next line to your hosts file:

    ```
    192.168.57.100  magento.local
    ```

7. Visit http://magento.local/
8. Follow the Magento installation instructions. At the ```Step 2: Add a Database``` step use next settings:

    ```
    Database Server Host: localhost
    Database Server Username: magentouser
    Database Server Password: magentoPwd
    Database Name: magentodb
    ```