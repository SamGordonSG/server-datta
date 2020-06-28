resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
-- http://www.skyrock.fm/stream.php/tunein16_128mp3.mp3
-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "http://radio6.pro-fhi.net:9005/listen/mp3", volume = 0.5, name = "Skyrock" }
supersede_radio "RADIO_02_POP" { url = "http://cdn.nrjaudio.fm/audio1/fr/40102/aac_576.mp3", volume = 0.2, name = "NRJ" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://radiofg.impek.com/fg.mp3", volume = 0.2, name = "Radio FG" }
supersede_radio "RADIO_04_PUNK" { url = "http://streaming.radio.funradio.fr:80/fun-1-44-128.mp3", volume = 0.2, name = "Fun Radio" }
supersede_radio "RADIO_05_TALK_01" { url = "http://start-adofm.ice.infomaniak.ch/start-adofm-high.mp3", volume = 0.2, name = "Swigg" }
supersede_radio "RADIO_06_COUNTRY" { url = "http://chai5she.lb.vip.cdn.dvmr.fr/rmcinfo", volume = 0.5, name = "RMC Sport" }
supersede_radio "RADIO_07_DANCE_01" { url = "http://mediaming.streamakaci.com/sanef107_7_NORD.mp3", volume = 0.2, name = "Sanef 107.7" }
supersede_radio "RADIO_08_MEXICAN" { url = "http://rfm-live-mp3-128.scdn.arkena.com/rfm.mp3", volume = 0.2, name = "RFM" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://direct.mouv.fr/live/mouv-midfi.mp3", volume = 0.2, name = "Le Mouv'" }
supersede_radio "RADIO_12_REGGAE" { url = " http://radionova.ice.infomaniak.ch/radionova-low.mp3", volume = 0.2, name = "Radio Nova" }
supersede_radio "RADIO_13_JAZZ" { url = "http://vr-live-mp3-128.scdn.arkena.com/virginradio.mp3", volume = 0.2, name = "Virgin Radio" }
supersede_radio "RADIO_14_DANCE_02" { url = "http://cdn.nrjaudio.fm/audio1/fr/30601/mp3_128.mp3?origine=fluxradios", volume = 0.2, name = "Nostalgie" }
supersede_radio "RADIO_15_MOTOWN" { url = "http://cdn.nrjaudio.fm/audio1/fr/30201/mp3_128.mp3?origine=fluxradios", volume = 0.2, name = "Cherie FM" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://e1-live-mp3-128.scdn.arkena.com/europe1.mp3", volume = 0.2, name = "Europe 1" }
supersede_radio "RADIO_17_FUNK" { url = "http://start-voltage.ice.infomaniak.ch/start-voltage-high.mp3", volume = 0.2, name = "Voltage" }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://generationfm.ice.infomaniak.ch/generationfm-high.mp3", volume = 0.2, name = "Generations" }
supersede_radio "RADIO_11_TALK_02" { url = "http://start-latina.ice.infomaniak.ch/start-latina-high.mp3", volume = 0.2, name = "Latina" }
supersede_radio "RADIO_20_THELAB" { url = "http://streaming.radio.rtl2.fr/rtl2-1-48-192", volume = 0.2, name = "RTL2" }
supersede_radio "RADIO_21_DLC_XM17" { url = "http://vibration.ice.infomaniak.ch/vibration-high.mp3", volume = 0.2, name = "Vibration" }
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "http://onlyrai.ice.infomaniak.ch/onlyrai-high.aac", volume = 0.2, name = "Urban Hit" }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}
