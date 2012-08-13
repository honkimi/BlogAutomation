require './app/translator/translate_sentence'
require './lib/IeHandler'


$ie = IeHandler::IePage.new("http://google.com/")

translate_sentence = TranslateSentence.new

translate_sentence.translate("Sex is confortable.")




