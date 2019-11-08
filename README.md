# UnityWithMax-M
# 説明
プロジェクトファイル内のAseets/Scenesにあるdemoを開くとMaxと通信可能状態のシーンが開きます。   
通信設定はHierarchyのGameObjectにアタッチされているOSC Controllerで設定されています。  
ServerIpの127.0.0.1はローカルホストを意味します。  
ServerPortは送信用のポート番号です。Portは受信用のポート番号です。
Aseetフォルダ内にデモ用の送信、受信パッチをそれぞれ用意しています。
# 使い方
demoシーンを開いたら、送信、受信パッチをそれぞれ起動します。そうしたら、プロジェクト(Unityの)プロジェクトを実行してください。  
gameビューをクリックした状態でSキーを押すとUnityToMaxのパッチのメッセージにログを出力します。
MaxToUnityをアクティブにした状態でボタン(Maxの)を押すとUnityのデバッグログに出力が行われます。
