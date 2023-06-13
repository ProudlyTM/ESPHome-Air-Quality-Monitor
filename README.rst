###########################
ESPHome Air Quality Monitor
###########################

.. image:: https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/workflows/Build/badge.svg
   :target: https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/actions
   :alt: Continuous integration

.. image:: https://img.shields.io/github/license/koenvervloesem/ESPHome-Air-Quality-Monitor.svg
   :target: https://github.com/koenvervloesem/ESPHome-Air-Quality-Monitor/blob/main/LICENSE
   :alt: License

This `ESPHome <https://esphome.io/>`_ configuration builds firmware for a DIY indoor air quality monitor. It monitors:

- CO₂ concentration
- PM2.5 and PM10 concentration
- temperature, humidity and pressure

It optionally shows feedback for the current air quality with an RGB LED: green if the air quality is good, yellow if it's acceptable, and red if it's bad.

************
Requirements
************

- ESP32 board
- `Winsen MH-Z19B <https://www.winsen-sensor.com/sensors/co2-sensor/mh-z19b.html>`_
- `Nova Fitness SDS011 <http://inovafitness.com/en/a/chanpinzhongxin/95.html>`_ particulate matter (PM) sensor
- `Bosch BME280 <https://www.bosch-sensortec.com/products/environmental-sensors/humidity-sensors-bme280/>`_ breakout board (the 3.3 V version)
- Common cathode RGB LED (or separate red, green and blue LEDs)
- 220 Ω resistor and two 47 Ω resistors
- DC/DC boost converter with 5 V output
- ESPHome

***********
Connections
***********

Here are the connections to the pins of the ESP32:

+--------------------+-----------------+
| Component          | ESP32           |
+====================+=================+
| BME280 SCL         | GPIO21          |
+--------------------+-----------------+
| BME280 SDA         | GPIO22          |
+--------------------+-----------------+
| MH-Z19B TX         | GPIO35          |
+--------------------+-----------------+
| MH-Z19B RX         | GPIO32          |
+--------------------+-----------------+
| SDS011 TX          | GPIO34          |
+--------------------+-----------------+
| SDS011 RX          | GPIO33          |
+--------------------+-----------------+
| LED red            | GPIO5           |
+--------------------+-----------------+
| LED green          | GPIO17          |
+--------------------+-----------------+
| LED blue           | GPIO16          |
+--------------------+-----------------+

Make sure to connect the power and ground connections too. The BME280 needs 3.3 V, the MH-Z19B and SDS011 need 5 V.

The red component of the RGB LED needs a current-limiting resistor of 220 Ω, while the other two color components need a 47 Ω resistor.

**********
Modularity
**********

This is a modular ESPHome configuration split up in various YAML files that you can import as `packages <https://esphome.io/guides/configuration-types.html#packages>`_. You can find these in the directory `common <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/tree/main/common>`_:

`aqi.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/aqi.yaml>`_
  Computes the air quality index (AQI) value (good, acceptable, bad) based on the current CO₂ concentration and the 24-hour averages of the PM2.5 and PM10 concentrations. This value is published as a text sensor and shown as a color (green, yellow, red) on the RGB LED.
`base.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/base.yaml>`_
  Sets up the basic ESPHome functionality for the board, including Wi-Fi, a captive portal, logger, Home Assistant API and OTA support. It also sets the threshold values for the CO₂, PM2.5 and PM10 concentrations, as well as the messages when the air quality is good, acceptable or bad.
`bme280.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/bme280.yaml>`_
  Sets up the BME280 sensor for temperature, humidity and pressure and the I²C bus it uses.
`mh-z19b.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/mh-z19b.yaml>`_
  Sets up the MH-Z19B CO₂ sensor, a binary sensor that shows whether the sensor has been calibrated yet (and sets the LED to blue when it isn't) and a switch to calibrate the sensor.
`no_feedback/aqi.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/no_feedback/aqi.yaml>`_
  Use this if you don't want to show AQI status.
`no_feedback/calibration.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/no_feedback/calibration.yaml>`_
  Use this if you don't want to show calibration status.
`rgb_led/aqi.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/rgb_led/aqi.yaml>`_
  Shows AQI status on the RGB LED.
`rgb_led/calibration.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/rgb_led/calibration.yaml>`_
  Shows calibration status on the RGB LED.
`rgb_led/esp32.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/rgb_led/esp32.yaml>`_
  Sets up the RGB LED on the ESP32 with its LEDC peripheral (a hardware PWM).
`sds011.yaml <https://github.com/ProudlyTM/ESPHome-Air-Quality-Monitor/blob/main/common/sds011.yaml>`_
  Sets up the SDS011 PM sensor.

*****
Usage
*****

.. code-block:: console

  esphome run esphome-air-quality-monitor-esp32.yaml

After you have added your device to Home Assistant's ESPHome integration, the air quality measurements are available in Home Assistant and you can start the calibration of the CO₂ sensor from within Home Assistant too.

**********************
Web-based installation
**********************

You can install the latest version of the firmware on your air quality monitor from the `installation page <https://proudlytm.github.io/ESPHome-Air-Quality-Monitor/>`_ via USB, as well as setting up Wi-Fi and adding the device to Home Assistant. This requires a web browser that supports `Web Serial <https://caniuse.com/web-serial>`_ (which is a recent Chrome, Edge or Opera).

*******
License
*******

This project is provided by `Koen Vervloesem <http://koen.vervloesem.eu>`_ as open source software with the MIT license. See the `LICENSE file <LICENSE>`_ for more information.

The included Roboto font is licensed under the `Apache License, Version 2.0 <https://fonts.google.com/specimen/Roboto#license>`_.

The C++/runtime codebase of the ESPHome project (file extensions .c, .cpp, .h, .hpp, .tcc, .ino) are published under the GPLv3 license. The Python codebase and all other parts of the ESPHome codebase are published under the MIT license. See the `ESPHome License <https://github.com/esphome/esphome/blob/dev/LICENSE>`_ for more information.