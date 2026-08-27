def prim(graph,start):
    visited = set()
    mst = []
    total_cost=0

    visited.add(start)
    while len(visited) < len(graph):
        minimum_edge = None
        minimum_weight=float('inf')

        #check all visited vertices
        for u in visited:
            #check their neighbours
            for v, weight in graph[u]:
                if v not in visited:
                    if weight < minimum_weight :
                        minimum_weight=weight
                        minimum_edge =(u,v,weight)

                        u,v,weight=minimum_edge 
                        mst.append((u,v,weight))
                        total_cost+=weight
                        visited.add(v)
                    return mst,total_cost
n = int(input("Enter number of vertices:"))
e = int(input("Enter number of edges:"))
graph={}
for i in range(n):
    vertex = input("Enter vertex:")
    graph[vertex]=[]
    print("Enter edges as:vertex1 vertex2 weight")
    for i in range(e):
        u,v,w=input().split()
        w=int(w)

        graph[u].append((v,w))
        graph[v].append((u,w))
start=input("Enter starting vertex:")
mst,cost=prim(graph,start)
print("\n Minimum spanning tree:")
for u,v,w in mst:
    print(u,"-",v,"=",w)
print("Total cost:",cost)