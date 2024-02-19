import { StyleSheet } from 'react-native';

const CoresStyle={
  'Black':'#000000',
  'White':'#ffffff',
  'PlaceHolder':'#7C7C7C',
  'BackColor':'#909090',
  'TopColor':'#d9d9d9'
}
const styles = StyleSheet.create({
  Centralizar:{
    display:'flex',
    justifyContent:'center',
    alignItems:'center',
    textAlign:'center',
    textAlignVertical:'center'
  },

  container:{
    margin:10,
    marginTop:25,
    padding:0
  },
  NavBar:{
    width: '100%',
    height: 35,
    backgroundColor: CoresStyle.TopColor,
    padding: 5,
    display: 'flex',
    flexDirection: 'row',
    borderRadius: 8,
  },
  NavButton:{
    width: 60,
    height: 25,
    backgroundColor: CoresStyle.BackColor,
    borderRadius: 5,
  },
  NavSpan:{
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    fontSize: 12,
    width: '82%',
    height: '100%',
    marginRight: 5,
    borderRadius: 6,
    backgroundColor: CoresStyle.BackColor
  },
  main:{
    display: 'flex',
    flexDirection: 'column',
    borderRadius: 5,
    margin: 5,
  },
  MainDiv:{
    padding: 5,
    marginBottom: 5,
    borderColor: 'Black',
    borderStyle: 'solid',
    borderWidth: .5,
    backgroundColor: CoresStyle.White,
    borderRadius:5
  },
  FilterBar:{
    padding:5,
    position:'absolute',
    width:'100%',
    height:'100%',
    backgroundColor:'rgba(0,0,0,.70)',
    zIndex:2,
    padding:10,
    paddingTop:25,
  },
  FilterBarFrame:{
    padding:5,
    width:'100%',
    height:'auto',
    backgroundColor: CoresStyle.TopColor,
    opacity:1,
  },
  FilterBarButton:{
    height:35,
    marginLeft:5,
    width:'18.5%',
    borderWidth: .5,
    backgroundColor: CoresStyle.White,
    borderRadius:5
  },
  FilterBarInput:{
    height:35,
    width:'80%',
    borderStyle: 'solid',
    borderWidth: .5,
    backgroundColor: CoresStyle.White,
    borderRadius:5

  },
  FilterBarDiv:{
    display:'flex',
    flexDirection:'row',
    marginTop:5
  },

  BotaoFechar:{
    aspectRatio: '1/1',
    backgroundColor:'#FF6161',
    fontSize:20,
    borderRadius: 10,
    borderWidth:.5,
    borderColor:'#000000'
  },
  BotaoEdit:{
    aspectRatio: '1/1',
    backgroundColor:'#6184FF',
    fontSize:20,
    borderRadius: 10,
    borderWidth:.5,
    borderColor:'#000000'
  },
});

export default styles;
