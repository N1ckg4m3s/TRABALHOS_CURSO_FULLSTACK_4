import { StatusBar } from 'expo-status-bar';
import { FlatList, ScrollView, StyleSheet, Text, View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native'; 
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// //  -- == Paginas == --
import DadosFornecedor from './Pages/DadosFornecedor/Pagina';
import ListaFornecedor from './Pages/ListaFornecedor/Pagina';
import CadastroFornecedor from './Pages/CadastroFornecedor/Pagina';
import GerarDadosTeste from './Controle/GerarDadosTeste';
import { useEffect } from 'react';
const Stack=createNativeStackNavigator()

export default function App() {
  /* COLOCAR DADOS TESTE */
  useEffect(()=>{
    GerarDadosTeste()
  },[])
  return (
    <NavigationContainer>
      <Stack.Navigator
      initialRouteName='LISTA_FORNECEDORES'>
        <Stack.Screen
          options={{ headerShown: false }}
          name="DADOS_FORNECEDORES"
          component={DadosFornecedor}
        ></Stack.Screen>
        <Stack.Screen
          options={{ headerShown: false }}
          name="LISTA_FORNECEDORES"
          component={ListaFornecedor}
        ></Stack.Screen>
        <Stack.Screen
          options={{ headerShown: false }}
          name="CADASTRO_FORNECEDORES"
          component={CadastroFornecedor}
        ></Stack.Screen>
      </Stack.Navigator>
    </NavigationContainer> 
  );
}