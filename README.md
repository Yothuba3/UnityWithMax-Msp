# UnityWithMax-M
# 説明
プロジェクトファイル内のAseets/Scenesにあるdemoを開くとMaxと通信可能状態のシーンが開きます。   
通信設定はHierarchyのGameObjectにアタッチされているOSC Controllerで設定されています。  
ServerIpの127.0.0.1はローカルホストを意味します。  
ServerPortは送信用のポート番号です。Portは受信用のポート番号です。
Aseetフォルダ内にデモ用の送信、受信パッチをそれぞれ用意しています。
# 使い方
demoシーンを開いたら、MaxToUnityMusicValueファイルを開いてください。そうしたら、プロジェクト(Unityの)プロジェクトを実行してください。  
MaxToUnityMusicValueのXボタン(上部にあります)とスピーカーみたいなマークのボタン(下部にあります）を有効化すると音声が流れる(はず)ます。
その音声の振幅の値がUnityに渡され、その値をもとにCubeが反応を起こす様子を観察できます。
