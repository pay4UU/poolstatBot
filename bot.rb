require 'telegram_bot'
token = '1031547535:AAHH4mcG7_4wcthYkCYYU-mbhj8rnBsmoR4'
bot = TelegramBot.new(token: token)

def hex2bin(s)
[self].pack('H*')
end

lastBlock=630946
lastHash="00000000000000000006e2f32de0a70bfd1bdfb9884796d14055e96c50d857eb"
bitcoinCli=`/usr/local/bin/bitcoin-cli -rpcuser=btccore -rpcpassword=btccore `

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /start/i
      reply.text = "All I can do is say hello to you, Thomas from southern sees. Try the /greet command."
   	when /greet/i
		greetings = ['bonjour', 'hola', 'hallo', 'sveiki', 'namaste', 'salaam', 'szia', 'halo', 'ciao']
   		# reply.text = "Hello, #{message.from.first_name}. 🤖"
      	reply.text = "#{greetings.sample.capitalize}, #{message.from.first_name}!"
      # greetings = ['bonjour', 'hola', 'hallo', 'sveiki', 'namaste', 'salaam', 'szia', 'halo', 'ciao']
      # reply.text = "#{greetings.sample.capitalize}, #{message.from.first_name}!"
    when /bitcoin/i
		reply.text = " It is awesome! Please call to F2Pool for more info"
    when /firstBlock/i
		reply.text = 'Our F2Pool repository sais that block exists: {  "hash": "000000002c05cc2e78923c34df87fd108b22221ac6076c18f3ade378a4d915e9",  "confirmations": 630935,  "strippedsize": 215,  "size": 215,  "weight": 860,  "height": 10,  "version": 1,  "versionHex": "00000001",  "merkleroot": "d3ad39fa52a89997ac7381c95eeffeaf40b66af7a57e9eba144be0a175a12b11",  "tx": [    "d3ad39fa52a89997ac7381c95eeffeaf40b66af7a57e9eba144be0a175a12b11"  ],  "time": 1231473952,  "mediantime": 1231471428,  "nonce": 1709518110,  "bits": "1d00ffff",  "difficulty": 1,  "chainwork": "0000000000000000000000000000000000000000000000000000000b000b000b",  "nTx": 1,  "previousblockhash": "000000008d9dc510f23c2657fc4f67bea30078cc05a90eb89e84cc475c080805",  "nextblockhash": "0000000097be56d606cdd9c54b04d4747e957d3608abe69198c661f2add73073"}'
    	# reply.text = " Our F2Pool repository sais that block exists: {  hash : 000000002c05cc2e78923c34df87fd108} "
  #   when /ls/i
  #    	output = `ls`
		# reply.text = "Pleas call Tom" + output
    when /getmininginfo/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getmininginfo`
		reply.text = "getmininginfo: \n" + output
	when /reward/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblock 00000000000000000006e2f32de0a70bfd1bdfb9884796d14055e96c50d857eb 2 | jsontool tx[0].vout[0].value`
		reply.text = "reward: \n" + output + " BTC"
	when /pool/i
      	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblock 00000000000000000006e2f32de0a70bfd1bdfb9884796d14055e96c50d857eb 2 | jsontool tx[0].vin[0].coinbase` #| xxd -r -p
	 	ouputText =output.gsub(/../) { |pair| pair.hex.chr }
	 	o= ouputText.gsub(/[^[:print:]]/,'.')
	 	reply.text = "last pool is: " + o# + words
	when /getblockcount/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblockcount`
		reply.text = "getblockcount: \n" + output
    when /getblockhash/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblockhash 630946`
		reply.text = "getblockhash: \n" + output
	when /getblockhash1/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblockhash 630946`
		reply.text = "getblockhash1: \n" + output
	when /blockhash/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblockhash 630946 `
		reply.text = "blockhash: \n" + output
	
	when /getblock/i
     	output = `bitcoin-cli -rpcuser=btccore -rpcpassword=btccore getblock 00000000000000000006e2f32de0a70bfd1bdfb9884796d14055e96c50d857eb 2 | jsontool -e this.tx=0| egrep "difficulty|time"`
		reply.text = "getblock: \n" + output




    else

      reply.text = "I have no idea what the hell #{command.inspect} means."
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
  end
end